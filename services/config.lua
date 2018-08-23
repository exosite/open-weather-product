-- If #EVENT tag has only 1 argument the file name is used as service alias

--#EVENT fallback
-- A fallback event triggered anytime the targeted event is not provided
-- Information regarding the triggered event are available in 'context' map
print(context, event)
