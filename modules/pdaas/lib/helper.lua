local h = {}

local e = require("pdaas.lib.errors")
local c = require("pdaas.lib.crypto")

function h.shallowcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == "table" then
    copy = {}
    for orig_key, orig_value in pairs(orig) do
      copy[orig_key] = orig_value
    end
  else -- number, string, boolean, etc
    copy = orig
  end
  return copy
end

function h.getAppToken(app_id, secret)
  return c.b64enc(app_id .. ":" .. secret)
end

function h.appTokenParser(auth_header)
  if auth_header then
    local type, token = auth_header:match("([^,]+) ([^,]+)")
    if type and token and string.lower(type) == "basic" then
      local decoded = c.b64dec(token)
      local app_id, secret = decoded:match("([^,]+):([^,]+)")
      if app_id and secret then
        return {app_id = app_id, secret = secret}
      end
    end
  end
  return nil, e.NOT_AUTHENTICATED
end


-- foreach, return on first non-nil fun return
function h.forEach(prefix, fun)
  local cursor = "0"
  if not prefix then
    prefix = "*"
  else
    prefix = prefix .. "*"
  end
  repeat
    local res = Keystore.list({match = prefix, cursor = cursor})
    if res.error ~= nil then
      return nil, "Failed to map keystore keys: " .. res.error
    end
    for _, k in ipairs(res.keys) do
      local res = fun(k)
      if res then
        return res
      end
    end
    cursor = res.cursor
  until (cursor == "0")
end

function h.delEach(prefix)
  local cursor = "0"
  if not prefix then
    prefix = "*"
  else
    prefix = prefix .. "*"
  end
  local res = {removed = 1}
  repeat
    res = Keystore.list({match = prefix, cursor = cursor})
    if res.error ~= nil then
      return nil, "Failed to map keystore keys: " .. res.error
    end
    res = Keystore.mdelete({ keys = res.keys })
  until (not res or not res.removed or res.removed == 0)
end

function h.hscan(hashset_key, prefix, count, start, is_json)
  if is_json == nil then
    is_json = true
  end
  local args = {}
  local recived
  if not start then
    start = "0"
  end
  args[1] = start
  args[2] = "COUNT"
  args[3] = "100"
  if prefix then
    args[4] = "MATCH"
    args[5] = prefix .. "*"
  end
  local scanresult = {}
  local scancount = 0
  local cursor = ""
  while (not count or scancount < count) and cursor ~= "0" do
    local result =
      Keystore.command(
      {
        key = hashset_key,
        command = "hscan",
        args = args
      }
    )
    cursor = result.value[1]
    args[1] = cursor
    local key = nil
    for i, v in ipairs(result.value[2]) do
      if scancount % 2 == 0 then
        if prefix == "" then
          key = v
        else
          key = v:gsub("^" .. prefix, "")
        end
      else
        local value = nil
        if is_json then
          value = from_json(v)
        else
          value = v
        end
        scanresult[key] = value
      end
      scancount = scancount + 1
    end
  end
  return {cursor, scanresult}
end

return h
