from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import ForeignKey
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class User(Base):
    __tablename__ = 'users'
    userid = Column(String(20), primary_key=True)
    first_name = Column(String(80))
    last_name = Column(String(80))

    def __init__(self, userid, first_name, last_name):
        self.userid = userid
        self.first_name = first_name
        self.last_name = last_name

    def __repr__(self):
        return '<User: %r Name: %r %r>' % (self.userid, self.first_name, self.last_name)


class Group(Base):
    __tablename__ = 'groups'
    groupid = Column(String(20), primary_key=True)

    def __init__(self, groupid):
        self.groupid = groupid

    def __repr__(self):
        return '<Group: %r>' % self.groupid


class UserGroups(Base):
    __tablename__ = 'usergroups'
    id = Column(Integer, primary_key=True)
    userid = Column(String(20), ForeignKey('users.userid'))
    groupid = Column(String(20), ForeignKey('groups.groupid'))

    def __init__(self, userid, groupid):
        self.userid = userid
        self.groupid = groupid

    def __repr__(self):
        return '<User and Group %r:%r>' % (self.userid, self.groupid)



if __name__ == "__main__":
    from sqlalchemy import create_engine
    from config import SQLALCHEMY_DATABASE_URI
    engine = create_engine(SQLALCHEMY_DATABASE_URI)
    Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)
