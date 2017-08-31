--#ENDPOINT POST /api/user
print("Creating a new user")

--#ENDPOINT GET /api/user/{user_id}
print("Fetch a given user" .. request.parameters.user_id)
