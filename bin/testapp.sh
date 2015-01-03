#! /bin/bash
#

# Test Happy Path
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

# Test Group and User Duplicates.  Test group not found on user post
curl -X POST http://localhost:5000/groups/work

curl -X POST http://localhost:5000/users/test03 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester03", "groups" : ["admin"]}'

curl -X POST http://localhost:5000/users/test10 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester03", "groups" : ["admin", "nogroup"]}'


curl -X GET http://localhost:5000/users/test01
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/users/test10
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work

echo -e "\n\nTwo groups and Three users should be created. \nPlus a 404 to great a group and user that already exist and put with group not found.\n\n"

# Happy Path
curl -X PUT http://localhost:5000/users/test01 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testie", "last_name" : "Tester", "groups" : ["admin", "work"]}'

curl -X PUT http://localhost:5000/users/test03 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "TesterThree", "groups" : ["admin", "work"]}'

# Test Required Fields
curl -X PUT http://localhost:5000/users/test03 \
    -H "Content-Type: application/json" \
    -d '{"name" : "Testy", "last_name" : "TesterThree", "groups" : ["admin", "work"]}'

curl -X PUT http://localhost:5000/users/test03 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "n_ame" : "TesterThree", "groups" : ["admin", "work"]}'

curl -X PUT http://localhost:5000/users/test03 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "TesterThree"}'


curl -X GET http://localhost:5000/users/test01
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work

echo -e "\n\nUsers test01 and test03 should have their names updated. Required fields test\n\n"

# Happy Path
curl -X DELETE http://localhost:5000/users/test01

# Test Not Found
curl -X DELETE http://localhost:5000/users/test01

curl -X GET http://localhost:5000/users/test01
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work

echo -e "\n\nUser test01 should be deleted then a not found request.\n\n"

# Happy Path
curl -X POST http://localhost:5000/users/test05 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester05", "groups" : ["work"]}'

curl -X PUT http://localhost:5000/groups/admin \
    -H "Content-Type: application/json" \
    -d '{"members" : ["test05", "test03"]}'

# Group Put Not Found, Required field "members" and User Not Found
curl -X PUT http://localhost:5000/groups/admin2 \
    -H "Content-Type: application/json" \
    -d '{"members" : ["test05", "test03"]}'

curl -X PUT http://localhost:5000/groups/admin \
    -H "Content-Type: application/json" \
    -d '{"users" : ["test01", "test03"]}'

curl -X PUT http://localhost:5000/groups/admin \
    -H "Content-Type: application/json" \
    -d '{"members" : ["test05", "test03", "test99"]}'

curl -X GET http://localhost:5000/users/test05
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work

echo -e "\n\nUser test05 added and then placed into the admin group. \nTest required field. \nTest PUT Group and User not found.\n\n"

# Happy Path
curl -X DELETE http://localhost:5000/groups/admin
# Group Not Found or no members in a group
curl -X DELETE http://localhost:5000/groups/admin
curl -X DELETE http://localhost:5000/groups/admin2

curl -X GET http://localhost:5000/users/test05
curl -X GET http://localhost:5000/users/test02
curl -X GET http://localhost:5000/users/test03
curl -X GET http://localhost:5000/groups/admin
curl -X GET http://localhost:5000/groups/work
curl -X GET http://localhost:5000/groups/nogroup

echo -e "\n\nAll members are removed from the admin group. \n404 for deleting admin members again. \n404 for not finding group. \n404 for group that doesnt exist"
