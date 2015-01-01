Deploy planet2 app

Prerequites

This app is deployed into a python virtual environment.  Reference to setup Python Virtual environments http://docs.python-guide.org/en/latest/dev/virtualenvs/


Create a python vitural environment

$ virtualenv planet2

Install requisite packages:

$ pip install -r requirements.txt

Create tables:

$ python models.py

Run service:

$ python app.py

Sample requests:

POST /users/<userid>

curl -X POST http://localhost:5000/users/test01 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester", "groups" : ["admin", "manager"]}'

DELETE /users/<userid>

curl -X DELETE http://localhost:5000/users/test01

PUT /users/<userid>

curl -X PUT http://localhost:5000/users/test01 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testie", "last_name" : "Tester", "groups" : ["admin", "manager"]}'

GET /groups/<group name>

curl -X GET http://localhost:5000/groups/admin

POST /groups/<group name>

curl -X POST http://localhost:5000/groups/admin

PUT /groups/<group name>

curl -X PUT http://localhost:5000/groups/admin \
    -H "Content-Type: application/json" \
    -d '{"members" : ["test01", "test03"]}'

DELETE /groups/<group name>

curl -X DELETE http://localhost:5000/groups/admin




