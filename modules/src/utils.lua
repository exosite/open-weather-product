
-- Make sure your variables are all "local". Also, module object name should match the module name.
local utils = { variable = "World"}

function utils.hello()
  return utils.variable
end

-- Module requires a return statement
return utils
