operation.solution_id = nil
require("murano2cloud").removeIdentity(operation.identity)
return Device2.removeIdentity(operation)
