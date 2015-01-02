from models import User
from models import Group
from models import UserGroups

from db import session

from flask import jsonify

from flask.ext.restful import reqparse
from flask.ext.restful import abort
from flask.ext.restful import Resource


class UsersAPI(Resource):

    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        self.reqparse.add_argument('first_name', type = str, required = True, help = 'No First Name provided', location = 'json')
        self.reqparse.add_argument('last_name', type = str, required = True, help = 'No Last Name provided', location = 'json')
        self.reqparse.add_argument('groups', type = list, required = True, help = 'No list of groups provided', location = 'json')
        super(UsersAPI, self).__init__()

    def post(self, userid):
        args = self.reqparse.parse_args()
        grouplist = args['groups']
      
        u = session.query(User).filter(User.userid == userid).all()
	if u:
            abort(400, message="User {} already exists".format(userid))
	   
        nu = User(userid, args['first_name'], args['last_name'])
	session.add(nu)
	for grp in args['groups']:
	    g = session.query(Group).filter(Group.groupid == grp).all()
	    if not g:
		session.rollback()
                abort(404, message="Group {} doesn't exist".format(grp))
	    usergroup = UserGroups(userid, grp)
            session.add(usergroup)
        session.commit()
        return {}, 201

    def get(self, userid):
        json_data = []
	glist = []

	u = session.query(User).filter(User.userid == userid).all()
	if not u:
            abort(404, message="User {} doesn't exist".format(userid))
        ug = session.query(UserGroups).filter(UserGroups.userid == userid).all()
        for col in ug:
            glist.append(col.groupid)
        for col in u:
            data = {'userid': col.userid,
                'first name': col.first_name,
                'last name': col.last_name,
                'groups': glist}
        json_data.append(data)

        return jsonify(items=json_data)
        

    def put(self, userid):
        args = self.reqparse.parse_args()
        grouplist = args['groups']
      
        u = session.query(User).filter(User.userid == userid).one()
	if not u:
            abort(404, message="User {} does not exist".format(userid))
	   
        session.query(UserGroups).filter(UserGroups.userid == userid).delete()
        u.first_name = args['first_name']
        u.last_name = args['last_name']
	for grp in args['groups']:
	    g = session.query(Group).filter(Group.groupid == grp).all()
	    if not g:
		session.rollback()
                abort(404, message="Group {} doesn't exist".format(grp))
	    usergroup = UserGroups(userid, grp)
            session.add(usergroup)
        session.commit()
        return {}, 200
	

    def delete(self, userid):

	u = session.query(User).filter(User.userid == userid).all()
	if not u:
            abort(404, message="User {} doesn't exist".format(userid))
	    
        session.query(UserGroups).filter(UserGroups.userid == userid).delete()
        session.query(User).filter(User.userid == userid).delete()
        session.commit()
        return {}, 204


class GroupsAPI(Resource):

    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        self.reqparse.add_argument('members', type = list, required = True, help = 'No list of users provided', location = 'json')
        super(GroupsAPI, self).__init__()

    def post(self, groupid):
	g = session.query(Group).filter(Group.groupid == groupid).all()
	if g:
            abort(400, message="Group {} already exists".format(groupid))
        ng = Group(groupid)
	session.add(ng)
	session.commit()
	return {}, 200
	

    def get(self, groupid):
	json_data = []
        userlist = []
        ug = session.query(UserGroups).filter(UserGroups.groupid == groupid).all()
	if not ug:
            abort(404, message="Group {} doesn't exist".format(groupid))

        for col in ug:
	    userlist.append(col.userid) 
        data = {'group': groupid,
                'users': userlist},
        json_data.append(data)

        return jsonify(items=json_data)


    def put(self, groupid):
        args = self.reqparse.parse_args()
      
        g = session.query(Group).filter(Group.groupid == groupid).all()
	if not g:
            abort(404, message="Group {} does not exist".format(groupid))
	   
        session.query(UserGroups).filter(UserGroups.groupid == groupid).delete()
	for m in args['members']:
	    qm = session.query(User).filter(User.userid == m).all()
	    if not qm:
		session.rollback()
                abort(404, message="User {} doesn't exist".format(m))
	    usergroup = UserGroups(m, groupid)
            session.add(usergroup)
        session.commit()
        return {}, 200
	

    def delete(self, groupid):
        grplist = session.query(UserGroups).filter(UserGroups.groupid == groupid).all()
        if not grplist:
            abort(404, message="Group {} doesn't have any members".format(groupid))
        session.query(UserGroups).filter(UserGroups.groupid == groupid).delete()
        session.commit()
        return {}, 204


