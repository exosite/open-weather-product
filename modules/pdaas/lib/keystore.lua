local ks = {}

local e = require "pdaas.lib.errors"
local ft = require "pdaas.lib.flat_table"

local function buildObj(keys, values)
  local obj = {}
  for i, k in ipairs(keys) do
    obj[k] = values[i]
  end
  return obj
end

function ks.delHash(key)
  local result = Keystore.delete({key = key})
  if result.error then
    return nil, e.UNABLE_TO_DELETE
  end
  return result.value
end

function ks.delHashFields(key, obj)
  local keys = ft.getKeys(obj)
  local result =
    Keystore.command(
    {
      key = key,
      command = "hdel",
      args = keys
    }
  )
  if result.error then
    return nil, e.UNABLE_TO_CREATE
  end
  return result.value
end

function ks.setHashFields(key, obj)
  local flat = ft.flatten(obj)
  local insert = {}
  for k, v in pairs(flat) do
    insert[#insert + 1] = k
    insert[#insert + 1] = v
  end
  local result =
    Keystore.command(
    {
      key = key,
      command = "hmset",
      args = insert
    }
  )

  if result.error then
    return nil, e.UNABLE_TO_CREATE
  end
  return result.value
end

function ks.getHashFields(key, schema)
  local keys = ft.getKeys(schema)
  local result =
    Keystore.command(
    {
      key = key,
      command = "hmget",
      args = keys
    }
  )
  if result.error then
    return nil, e.UNABLE_TO_CREATE
  end
  local obj = buildObj(keys, result.value)
  return ft.unflatten(obj, schema)
end

return ks
