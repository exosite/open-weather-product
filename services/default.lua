-- If #EVENT tag have 2 arguments the file name & path are ignored

--#EVENT scripts echo
-- Custom event which can be called through ```lua Scripts.trigger({event = "echo", data = "hello"})```
return data

--#EVENT {myfutureproduct} event
-- 'myfutureproduct' is not an existing service alias and will be linked at runtime
-- Service id triggering the event is available in 'context.service'
print(context.service, event.type)
