
local Example = {}

function Example.complexThing(args)
    print("Running complexThing with arguments: "..to_json(args))
end

-- Module should have a return statement

return Example
