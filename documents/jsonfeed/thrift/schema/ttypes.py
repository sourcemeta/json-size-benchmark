#
# Autogenerated by Thrift Compiler (0.13.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#
#  options string: py
#

from thrift.Thrift import TType, TMessageType, TFrozenDict, TException, TApplicationException
from thrift.protocol.TProtocol import TProtocolException
from thrift.TRecursive import fix_spec

import sys

from thrift.transport import TTransport
all_structs = []


class Author(object):
    """
    Attributes:
     - name
     - url
     - avatar

    """


    def __init__(self, name=None, url=None, avatar=None,):
        self.name = name
        self.url = url
        self.avatar = avatar

    def read(self, iprot):
        if iprot._fast_decode is not None and isinstance(iprot.trans, TTransport.CReadableTransport) and self.thrift_spec is not None:
            iprot._fast_decode(self, iprot, [self.__class__, self.thrift_spec])
            return
        iprot.readStructBegin()
        while True:
            (fname, ftype, fid) = iprot.readFieldBegin()
            if ftype == TType.STOP:
                break
            if fid == 1:
                if ftype == TType.STRING:
                    self.name = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.STRING:
                    self.url = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 3:
                if ftype == TType.STRING:
                    self.avatar = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            else:
                iprot.skip(ftype)
            iprot.readFieldEnd()
        iprot.readStructEnd()

    def write(self, oprot):
        if oprot._fast_encode is not None and self.thrift_spec is not None:
            oprot.trans.write(oprot._fast_encode(self, [self.__class__, self.thrift_spec]))
            return
        oprot.writeStructBegin('Author')
        if self.name is not None:
            oprot.writeFieldBegin('name', TType.STRING, 1)
            oprot.writeString(self.name.encode('utf-8') if sys.version_info[0] == 2 else self.name)
            oprot.writeFieldEnd()
        if self.url is not None:
            oprot.writeFieldBegin('url', TType.STRING, 2)
            oprot.writeString(self.url.encode('utf-8') if sys.version_info[0] == 2 else self.url)
            oprot.writeFieldEnd()
        if self.avatar is not None:
            oprot.writeFieldBegin('avatar', TType.STRING, 3)
            oprot.writeString(self.avatar.encode('utf-8') if sys.version_info[0] == 2 else self.avatar)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.name is None:
            raise TProtocolException(message='Required field name is unset!')
        if self.url is None:
            raise TProtocolException(message='Required field url is unset!')
        if self.avatar is None:
            raise TProtocolException(message='Required field avatar is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)


class Item(object):
    """
    Attributes:
     - id
     - url
     - content_text
     - date_published

    """


    def __init__(self, id=None, url=None, content_text=None, date_published=None,):
        self.id = id
        self.url = url
        self.content_text = content_text
        self.date_published = date_published

    def read(self, iprot):
        if iprot._fast_decode is not None and isinstance(iprot.trans, TTransport.CReadableTransport) and self.thrift_spec is not None:
            iprot._fast_decode(self, iprot, [self.__class__, self.thrift_spec])
            return
        iprot.readStructBegin()
        while True:
            (fname, ftype, fid) = iprot.readFieldBegin()
            if ftype == TType.STOP:
                break
            if fid == 1:
                if ftype == TType.STRING:
                    self.id = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.STRING:
                    self.url = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 3:
                if ftype == TType.STRING:
                    self.content_text = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 4:
                if ftype == TType.STRING:
                    self.date_published = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            else:
                iprot.skip(ftype)
            iprot.readFieldEnd()
        iprot.readStructEnd()

    def write(self, oprot):
        if oprot._fast_encode is not None and self.thrift_spec is not None:
            oprot.trans.write(oprot._fast_encode(self, [self.__class__, self.thrift_spec]))
            return
        oprot.writeStructBegin('Item')
        if self.id is not None:
            oprot.writeFieldBegin('id', TType.STRING, 1)
            oprot.writeString(self.id.encode('utf-8') if sys.version_info[0] == 2 else self.id)
            oprot.writeFieldEnd()
        if self.url is not None:
            oprot.writeFieldBegin('url', TType.STRING, 2)
            oprot.writeString(self.url.encode('utf-8') if sys.version_info[0] == 2 else self.url)
            oprot.writeFieldEnd()
        if self.content_text is not None:
            oprot.writeFieldBegin('content_text', TType.STRING, 3)
            oprot.writeString(self.content_text.encode('utf-8') if sys.version_info[0] == 2 else self.content_text)
            oprot.writeFieldEnd()
        if self.date_published is not None:
            oprot.writeFieldBegin('date_published', TType.STRING, 4)
            oprot.writeString(self.date_published.encode('utf-8') if sys.version_info[0] == 2 else self.date_published)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.id is None:
            raise TProtocolException(message='Required field id is unset!')
        if self.url is None:
            raise TProtocolException(message='Required field url is unset!')
        if self.content_text is None:
            raise TProtocolException(message='Required field content_text is unset!')
        if self.date_published is None:
            raise TProtocolException(message='Required field date_published is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)


class Main(object):
    """
    Attributes:
     - version
     - user_comment
     - title
     - home_page_url
     - feed_url
     - author
     - items

    """


    def __init__(self, version=None, user_comment=None, title=None, home_page_url=None, feed_url=None, author=None, items=None,):
        self.version = version
        self.user_comment = user_comment
        self.title = title
        self.home_page_url = home_page_url
        self.feed_url = feed_url
        self.author = author
        self.items = items

    def read(self, iprot):
        if iprot._fast_decode is not None and isinstance(iprot.trans, TTransport.CReadableTransport) and self.thrift_spec is not None:
            iprot._fast_decode(self, iprot, [self.__class__, self.thrift_spec])
            return
        iprot.readStructBegin()
        while True:
            (fname, ftype, fid) = iprot.readFieldBegin()
            if ftype == TType.STOP:
                break
            if fid == 1:
                if ftype == TType.STRING:
                    self.version = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.STRING:
                    self.user_comment = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 3:
                if ftype == TType.STRING:
                    self.title = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 4:
                if ftype == TType.STRING:
                    self.home_page_url = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 5:
                if ftype == TType.STRING:
                    self.feed_url = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 6:
                if ftype == TType.STRUCT:
                    self.author = Author()
                    self.author.read(iprot)
                else:
                    iprot.skip(ftype)
            elif fid == 7:
                if ftype == TType.LIST:
                    self.items = []
                    (_etype3, _size0) = iprot.readListBegin()
                    for _i4 in range(_size0):
                        _elem5 = Item()
                        _elem5.read(iprot)
                        self.items.append(_elem5)
                    iprot.readListEnd()
                else:
                    iprot.skip(ftype)
            else:
                iprot.skip(ftype)
            iprot.readFieldEnd()
        iprot.readStructEnd()

    def write(self, oprot):
        if oprot._fast_encode is not None and self.thrift_spec is not None:
            oprot.trans.write(oprot._fast_encode(self, [self.__class__, self.thrift_spec]))
            return
        oprot.writeStructBegin('Main')
        if self.version is not None:
            oprot.writeFieldBegin('version', TType.STRING, 1)
            oprot.writeString(self.version.encode('utf-8') if sys.version_info[0] == 2 else self.version)
            oprot.writeFieldEnd()
        if self.user_comment is not None:
            oprot.writeFieldBegin('user_comment', TType.STRING, 2)
            oprot.writeString(self.user_comment.encode('utf-8') if sys.version_info[0] == 2 else self.user_comment)
            oprot.writeFieldEnd()
        if self.title is not None:
            oprot.writeFieldBegin('title', TType.STRING, 3)
            oprot.writeString(self.title.encode('utf-8') if sys.version_info[0] == 2 else self.title)
            oprot.writeFieldEnd()
        if self.home_page_url is not None:
            oprot.writeFieldBegin('home_page_url', TType.STRING, 4)
            oprot.writeString(self.home_page_url.encode('utf-8') if sys.version_info[0] == 2 else self.home_page_url)
            oprot.writeFieldEnd()
        if self.feed_url is not None:
            oprot.writeFieldBegin('feed_url', TType.STRING, 5)
            oprot.writeString(self.feed_url.encode('utf-8') if sys.version_info[0] == 2 else self.feed_url)
            oprot.writeFieldEnd()
        if self.author is not None:
            oprot.writeFieldBegin('author', TType.STRUCT, 6)
            self.author.write(oprot)
            oprot.writeFieldEnd()
        if self.items is not None:
            oprot.writeFieldBegin('items', TType.LIST, 7)
            oprot.writeListBegin(TType.STRUCT, len(self.items))
            for iter6 in self.items:
                iter6.write(oprot)
            oprot.writeListEnd()
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.version is None:
            raise TProtocolException(message='Required field version is unset!')
        if self.user_comment is None:
            raise TProtocolException(message='Required field user_comment is unset!')
        if self.title is None:
            raise TProtocolException(message='Required field title is unset!')
        if self.home_page_url is None:
            raise TProtocolException(message='Required field home_page_url is unset!')
        if self.feed_url is None:
            raise TProtocolException(message='Required field feed_url is unset!')
        if self.author is None:
            raise TProtocolException(message='Required field author is unset!')
        if self.items is None:
            raise TProtocolException(message='Required field items is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)
all_structs.append(Author)
Author.thrift_spec = (
    None,  # 0
    (1, TType.STRING, 'name', 'UTF8', None, ),  # 1
    (2, TType.STRING, 'url', 'UTF8', None, ),  # 2
    (3, TType.STRING, 'avatar', 'UTF8', None, ),  # 3
)
all_structs.append(Item)
Item.thrift_spec = (
    None,  # 0
    (1, TType.STRING, 'id', 'UTF8', None, ),  # 1
    (2, TType.STRING, 'url', 'UTF8', None, ),  # 2
    (3, TType.STRING, 'content_text', 'UTF8', None, ),  # 3
    (4, TType.STRING, 'date_published', 'UTF8', None, ),  # 4
)
all_structs.append(Main)
Main.thrift_spec = (
    None,  # 0
    (1, TType.STRING, 'version', 'UTF8', None, ),  # 1
    (2, TType.STRING, 'user_comment', 'UTF8', None, ),  # 2
    (3, TType.STRING, 'title', 'UTF8', None, ),  # 3
    (4, TType.STRING, 'home_page_url', 'UTF8', None, ),  # 4
    (5, TType.STRING, 'feed_url', 'UTF8', None, ),  # 5
    (6, TType.STRUCT, 'author', [Author, None], None, ),  # 6
    (7, TType.LIST, 'items', (TType.STRUCT, [Item, None], False), None, ),  # 7
)
fix_spec(all_structs)
del all_structs