#! /bin/bash
#
#
#GET /users/<userid>
#    Returns the matching user record or 404 if none exist.
#
#curl -X GET http://localhost:5000/users/test01

#POST /users/<userid>
#   Creates a new user record. The body of the request should be a valid user
#    record. POSTs to an existing user should be treated as errors and flagged
#    with the appropriate HTTP status code.
#
#curl -X POST http://localhost:5000/users/test01 \
#    -H "Content-Type: application/json" \
#    -d '{"first_name" : "Testy", "last_name" : "Tester", "groups" : ["admin", "manager"]}'

#DELETE /users/<userid>
#   Deletes a user record. Returns 404 if the user doesn't exist.
#
#curl -X DELETE http://localhost:5000/users/test01

#PUT /users/<userid>
#   Updates an existing user record. The body of the request should be a valid
#   user record. PUTs to a non-existant user should return a 404.
#
#curl -X PUT http://localhost:5000/users/test01 \
#    -H "Content-Type: application/json" \
#    -d '{"first_name" : "Testie", "last_name" : "Tester", "groups" : ["admin", "manager"]}'
#
#curl -X PUT http://localhost:5000/users/test01 \
#    -H "Content-Type: application/json" \
#    -d '{"first_name" : "Testie", "last_name" : "Tester", "groups" : ["admin", "team"]}'

#GET /groups/<group name>
#    Returns a JSON list of userids containing the members of that group. Should
#    return a 404 if the group doesn't exist or has no members.
#
#curl -X GET http://localhost:5000/groups/admin

#POST /groups/<group name>
#    Creates a empty group. POSTs to an existing group should be treated as
#    errors and flagged with the appropriate HTTP status code.
#
#curl -X POST http://localhost:5000/groups/admin

#PUT /groups/<group name>
#    Updates the membership list for the group. The body of the request should 
#    be a JSON list describing the group's members.
#
#curl -X PUT http://localhost:5000/groups/admin \
#    -H "Content-Type: application/json" \
#    -d '{"users" : ["test01", "test03"]}'
#
#curl -X PUT http://localhost:5000/groups/admin \
#    -H "Content-Type: application/json" \
#    -d '{"users" : ["test01", "test03", "test04"]}'

#DELETE /groups/<group name>
#    Removes all members from the named group. Should return a 404 for unknown 
#    rgroups.
#
#curl -X DELETE http://localhost:5000/groups/admin
#


# Happy Path
#

curl -X POST http://localhost:5000/groups/admin
curl -X POST http://localhost:5000/groups/work

curl -X POST http://localhost:5000/users/test01 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester", "groups" : ["admin", "work"]}'

curl -X POST http://localhost:5000/users/test02 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester02", "groups" : ["work"]}'

curl -X POST http://localhost:5000/users/test03 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester03", "groups" : ["admin"]}'

curl -X GET http://localhost:5000/users/test01
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work

curl -X PUT http://localhost:5000/users/test01 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testie", "last_name" : "Tester", "groups" : ["admin", "work"]}'

curl -X PUT http://localhost:5000/users/test03 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "TesterThree", "groups" : ["admin", "work"]}'

curl -X GET http://localhost:5000/users/test01
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work

curl -X DELETE http://localhost:5000/users/test01

curl -X GET http://localhost:5000/users/test01
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work

curl -X POST http://localhost:5000/users/test05 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester05", "groups" : ["work"]}'

curl -X PUT http://localhost:5000/groups/admin \
    -H "Content-Type: application/json" \
    -d '{"users" : ["test05", "test03"]}'

curl -X GET http://localhost:5000/users/test05
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work

curl -X DELETE http://localhost:5000/groups/admin

curl -X GET http://localhost:5000/users/test05
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work
