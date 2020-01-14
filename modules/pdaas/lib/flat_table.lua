local ft = {}

local vt = {
  STRING = 0,
  NUMBER = 1,
  BOOLEAN = 2
}

local function tableMerge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        tableMerge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

local mt = {}
mt.__eq = function(lhs, rhs)
  return lhs.id == rhs.id
end

local function value_type(type_id, default_val)
  local self = {
    id = type_id,
    default = default_val,
    is_value_type = true
  }
  setmetatable(self, mt)

  function self.with_default(default_val)
    return value_type(self.id, default_val)
  end

  return self
end

local ft = {
  string = value_type(vt.STRING),
  number = value_type(vt.NUMBER),
  boolean = value_type(vt.BOOLEAN),
  table = value_type(vt.TABLE)
}

function ft.as_string(default)
  return value_type(vt.STRING, default)
end
function ft.as_number(default)
  return value_type(vt.NUMBER, default)
end
function ft.as_boolean(default)
  return value_type(vt.BOOLEAN, default)
end

local function toboolean(x)
  if x == "true" then
    return true
  elseif x == "false" then
    return false
  else
    return nil
  end
end

local j = json or {}
ft.null = j.null or {}

-- Flatten object
local function flatten(obj, prefix, flat)
  local prefix = prefix or ""
  local flat = flat or {}
  for k, v in pairs(obj) do
    local vtype = type(v)
    local pk = prefix .. k
    if vtype == "string" then
      flat[pk] = v
    elseif vtype == "number" then
      flat[pk] = tostring(v)
    elseif vtype == "boolean" then
      flat[pk] = tostring(v)
    elseif vtype == "table" then
      if v ~= ft.null then
        flat = flatten(v, pk .. ".", flat)
      end
    end
  end
  return flat
end

function ft.flatten(obj, prefix)
  return flatten(obj, prefix)
end

function ft.getKeys(schema, keys, prefix)
  local keys = keys or {}
  local prefix = prefix or ""
  for key, v in pairs(schema) do
    local vtype = type(v)
    local pk = prefix .. key
    keys[#keys + 1] = pk
    if not v.is_value_type and vtype == "table" then
      ft.getKeys(v, keys, pk .. ".")
    end
  end
  return keys
end

-- Unflatten object based on schema
local function unflatten(flat, schema, prefix)
  local prefix = prefix or ""
  local obj = {}
  for k, v in pairs(schema) do
    local pk = prefix .. k
    local fval = flat[pk]
    local vtype = type(v)
    local parsed = nil
    if not v.is_value_type and vtype == "table" then
      parsed = unflatten(flat, v, pk .. ".")
    elseif fval ~= nil then
      if v == ft.string then
        parsed = tostring(fval)
      elseif v == ft.number then
        parsed = tonumber(fval)
      elseif v == ft.boolean then
        parsed = toboolean(fval)
      end
    end
    obj[k] = (parsed or v.default) or ft.null
  end
  return obj
end

function ft.unflatten(flat, schema)
  return unflatten(flat, schema)
end

return ft
