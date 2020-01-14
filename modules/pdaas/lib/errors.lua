local e = {
  WRONG_PARAMETERS = {
    code = 400,
    message = "Wrong or missing parameters"
  },
  NOT_AUTHENTICATED = {
    code = 401,
    message = "Not authenticated"
  },
  NOT_AUTHORIZED = {
    code = 403,
    message = "Not authorized"
  },
  NOT_FOUND = {
    code = 404,
    message = "Not found"
  },
  DUPLICATED = {
    code = 409,
    message = "Duplicated element"
  },
  PRECONDITION_FAILED = {
    code = 412,
    message = "Precondition failed"
  },
  INTERNAL = {
    code = 500,
    message = "Internal server error"
  }
}

function e.get(code, message)
  local err = e[code] or e.INTERNAL
  local message = (message or not e[code]) and (err.message .. ": " .. (message or code)) or err.message
  return {
    code = err.code,
    message = message
  }
end

return e
