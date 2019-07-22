operation.solution_id = nil
require("murano2cloud").addIdentity(operation.identity)
return Device2.addIdentity(operation)
