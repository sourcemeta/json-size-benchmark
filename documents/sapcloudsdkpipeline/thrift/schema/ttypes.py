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


class Main(object):
    """
    Attributes:
     - general
     - stages
     - steps

    """


    def __init__(self, general=None, stages=None, steps=None,):
        self.general = general
        self.stages = stages
        self.steps = steps

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
                    self.general = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.STRING:
                    self.stages = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 3:
                if ftype == TType.STRING:
                    self.steps = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
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
        if self.general is not None:
            oprot.writeFieldBegin('general', TType.STRING, 1)
            oprot.writeString(self.general.encode('utf-8') if sys.version_info[0] == 2 else self.general)
            oprot.writeFieldEnd()
        if self.stages is not None:
            oprot.writeFieldBegin('stages', TType.STRING, 2)
            oprot.writeString(self.stages.encode('utf-8') if sys.version_info[0] == 2 else self.stages)
            oprot.writeFieldEnd()
        if self.steps is not None:
            oprot.writeFieldBegin('steps', TType.STRING, 3)
            oprot.writeString(self.steps.encode('utf-8') if sys.version_info[0] == 2 else self.steps)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)
all_structs.append(Main)
Main.thrift_spec = (
    None,  # 0
    (1, TType.STRING, 'general', 'UTF8', None, ),  # 1
    (2, TType.STRING, 'stages', 'UTF8', None, ),  # 2
    (3, TType.STRING, 'steps', 'UTF8', None, ),  # 3
)
fix_spec(all_structs)
del all_structs
