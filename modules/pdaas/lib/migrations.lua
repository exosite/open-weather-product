local m = {}
local ks = require("pdaas.lib.keystore")
local c = require("pdaas.lib.crypto")
local h = require("pdaas.lib.helper")

-- migration = {
--  name = string
--  version = 1-n number # incrimental version number, use one larger than previous avaliable migration
--  on_create = bool (optional, default false) # run this migration script even on new solution creation,
--  execute = function # migration function, takes no parameters and returns error string or nil if no error
--}
local migrations = {
  {
    name = "separate app instance from group",
    version = 1,
    on_create = true,
    execute = function ()
      local prefix = "g_"

      h.forEach(prefix, function (key)
        local group_id = string.sub(key, 3)
        local has_new_app = false
        local has_new_user = false
        local new_tags = {}
        local user_ids = {}
        local user_data = {}
        local ext_apps_map = {}

        -- Migrate apps
        local apps, err = h.hscan(key, "a_", nil, nil, true)
        if err then return "failed to scan apps" end
        for id, app in pairs(apps[2] or {}) do
          if app.t == 2 then
            id = "ext_" .. id
            ext_apps_map[id] = app
          end
          user_data["app_" .. id] = "{}"
          table.insert(new_tags, {name = "apps", value = id})
          has_new_app = true
        end

        -- Migrate user
        local users, err = h.hscan(key, "u_", nil, nil, true)
        if err then return "failed to scan users" end
        local apps_owner
        for id, user in pairs(users[2] or {}) do
          apps_owner = user.id
          user_data.id = user.id
          local res = User.createUserData(user_data)
          if res.error then
            log.error("Failed to migrate user " .. id, res.error)
          end
          if user.email then
            table.insert(new_tags, {name = "users", value = user.email})
            table.insert(user_ids, id)
            has_new_user = true
          end
        end

        if apps_owner then
          for id, app in pairs(ext_apps_map) do
            app.o = apps_owner
            ks.setHashFields(id, app)
          end
        end

        local operation = {limit = 5000}
        operation.tag = {name = "group", value = group_id}
        local res = Device2.listIdentities(operation)
        if res.code then
          return "failed to list devices"
        end
        for i, device in ipairs(res.devices) do
          local device_id = device.identity
          if has_new_user or has_new_app then
            Device2.addIdentityTag({
              identity = device_id,
              tags = new_tags
            })
          end
          Device2.removeIdentityTag({identity = device_id, name = "group"})
        end
        Keystore.delete({ key = key })
        for i, id in ipairs(user_ids) do
          Keystore.delete({key = "ug_" .. id})
        end
      end)

      -- Delete other keys
      h.delEach("gt_")
    end
  },
}


function m.run()
  local migration_nonce = context.tracking_id or c.randomString(20)
  local status =
    Keystore.command(
    {
      key = "migration_status",
      command = "setnx",
      args = {migration_nonce}
    }
  )
  if status.error ~= nil then
    return nil, "Failed to start migrations: " .. status.error
  end
  if status.value == "0" then
    return nil, "Failed to start migrations: migration already running in another process?"
  end
  local result = Keystore.get({key = "schema_version"})
  if result.error ~= nil then
    return nil, "Failed to start migrations: unable to get current schema version"
  end

  local current_version = tonumber(result.value) or 0
  local is_creation = current_version == 0
  for i, migration in ipairs(migrations) do
    local on_create = migration.on_create or false
    if ((not is_creation) and migration.version > current_version) or (is_creation and on_create) then
      local err = migration.execute()
      if err ~= nil then
        return false, err
      end
    end
    current_version = migration.version
  end
  local result = Keystore.set({key = "schema_version", value = tostring(current_version)})
  if result.error ~= nil then
    return nil, "Failed to set schema version: " .. result.error
  end
  local delete = Keystore.delete({key = "migration_status"})
  if delete.error ~= nil then
    return nil, "Failed to remove migration status: " .. delete.error
  end
  return current_version, nil
end

return m
