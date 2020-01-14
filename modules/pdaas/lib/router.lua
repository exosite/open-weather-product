local Router = {}
Router.__index = Router

local e = require("pdaas.lib.errors")

local function _set_response(response, r)
  if r.code then
    response.code = r.code
  end
  if r.message then
    response.message = r.message
  end
  if r.file then
    response.file = r.file
  end
  if r.headers then
    response.headers = r.headers
  end
end

local function _default_on_error(error)
  if type(error) == "string" then
    return {code = 500, message = error}
  elseif error.code and error.message then
    return error
  end
  return e.INTERNAL
end

local function _exec_func_wrap(context, f)
  return function()
    local p_result, parent_error_response = context.parent.f()
    -- Push error response forward
    if parent_error_response then
      return nil, parent_error_response
    end
    local result, error = f(p_result)

    if error then
      local handler = context.error_handlers[error] or context.default_error_handler
      -- Error handlers return error response first, and a optional sucess object second
      local error, success = handler(error)
      return success, error
    else
      return result, nil
    end
  end
end

local function step()
  local r = {}
  setmetatable(r, Router)
  r.error_handlers = {}
  return r
end

function Router:start(data)
  local s = step()
  s.f = function()
    return data
  end
  s.default_error_handler = _default_on_error
  return s
end

function Router:run(f)
  local s = step()
  s.default_error_handler = self.default_error_handler
  s.parent = self
  s.f = _exec_func_wrap(s, f)
  return s
end

function Router:on_error_default(f)
  if type(f) == "function" then
    self.default_error_handler = f
  else
    self.default_error_handler = function()
      return f
    end
  end
  return self
end

function Router:on_error(err, f)
  if type(f) == "function" then
    self.error_handlers[err] = f
  else
    self.error_handlers[err] = function()
      return f
    end
  end
  return self
end

-- Wraps successful function chain into a response object
function Router:response(r)
  if not r then
    r = response
  end
  local s, e_response = self.f()
  if e_response then
    _set_response(r, e_response)
  else
    _set_response(r, {message = s})
  end
  return r
end

-- No response object wrappring, assumes last function in chance returns response object
function Router:done(r)
  if not r then
    r = response
  end
  local s_response, e_response = self.f()
  if e_response then
    _set_response(r, e_response)
  else
    _set_response(r, s_response)
  end
  return r
end

return Router
