#!/usr/bin/env python

from flask import Flask
from flask.ext.restful import Api

app = Flask(__name__)
api = Api(app)

from controller import UsersAPI
from controller import GroupsAPI

api.add_resource(UsersAPI, '/users/<string:userid>', endpoint='users')
api.add_resource(GroupsAPI, '/groups/<string:groupid>', endpoint='groups')

if __name__ == '__main__':
    app.run(debug=True)
