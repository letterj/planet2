<h1> Planet2 App

**A very simple web service dealing with users and group.**  

<h3> Deployment

<h4> Prerequites:

This app is deployed into a python virtual environment.  [Reference](http://docs.python-guide.org/en/latest/dev/virtualenvs/)

The source code is stored in a public git repository.

<h4> Create a deployment directory:

    $ mkdir deploy

<h4> Create a python vitural environment and activate it

    $ virtualenv flask
    $ source flask/bin/activate

<h4> Get the source code from [Git](http://github.com)

    $  git clone http://github.com/letterj/planet2.git

<h4> Install dependent packages:

    $ pip install -r planet2/requirements.txt

<h4> Create tables:

    $ python planet2/models.py

<h4> Run service:

    $ python planet2/app.py

<h3> Sample requests:

**GET /users/_userid_**
* 200 - OK
* 404 - _userid_ not found

<pre>
curl -X GET http://localhost:5000/users/test01
</pre>

**POST /users/_userid_**
* 201 - Created
* 400 - _userid_ already exists
* 400 - Any of the required parameters not found ("first_name", "last_name", "groups"
* 404 - an item(group) in the "groups" list is not found

<pre>
curl -X POST http://localhost:5000/users/test01 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testy", "last_name" : "Tester", "groups" : ["admin", "manager"]}'
</pre>

**DELETE /users/_userid_**
* 204 - Deleted
* 404 - _userid_ was not found

<pre>
curl -X DELETE http://localhost:5000/users/test01
</pre>

**PUT /users/_userid_**
* 200 - OK
* 400 - _userid_ was not found
* 400 - Any of the required parameters not found ("first_name", "last_name", "groups"
* 404 - an item(group) in the "groups" list is not found

<pre>
curl -X PUT http://localhost:5000/users/test01 \
    -H "Content-Type: application/json" \
    -d '{"first_name" : "Testie", "last_name" : "Tester", "groups" : ["admin", "manager"]}'
</pre>

**GET /groups/_group name_**
* 200 - OK
* 404 - _group name_ not found

<pre>
curl -X GET http://localhost:5000/groups/admin
</pre>

**POST /groups/_group name_**
* 201 - Created
* 400 - _group name_ already exists

<pre>
curl -X POST http://localhost:5000/groups/admin
</pre>

**PUT /groups/_group name_**
* 200 - OK
* 400 - The required parameter "members" is not present

<pre>
curl -X PUT http://localhost:5000/groups/admin \
    -H "Content-Type: application/json" \
    -d '{"members" : ["test01", "test03"]}'
</pre>

**DELETE /groups/_group name_**
* 204 - DELETES the reference to all users in this group
* 404 - _group name_ not found or no users in this group

<pre>
curl -X DELETE http://localhost:5000/groups/admin
</pre>



