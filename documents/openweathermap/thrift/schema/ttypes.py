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


class Coord(object):
    """
    Attributes:
     - lon
     - lat

    """


    def __init__(self, lon=None, lat=None,):
        self.lon = lon
        self.lat = lat

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
                if ftype == TType.DOUBLE:
                    self.lon = iprot.readDouble()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.DOUBLE:
                    self.lat = iprot.readDouble()
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
        oprot.writeStructBegin('Coord')
        if self.lon is not None:
            oprot.writeFieldBegin('lon', TType.DOUBLE, 1)
            oprot.writeDouble(self.lon)
            oprot.writeFieldEnd()
        if self.lat is not None:
            oprot.writeFieldBegin('lat', TType.DOUBLE, 2)
            oprot.writeDouble(self.lat)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.lon is None:
            raise TProtocolException(message='Required field lon is unset!')
        if self.lat is None:
            raise TProtocolException(message='Required field lat is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)


class Weather(object):
    """
    Attributes:
     - id
     - main
     - description
     - icon

    """


    def __init__(self, id=None, main=None, description=None, icon=None,):
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon

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
                if ftype == TType.I16:
                    self.id = iprot.readI16()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.STRING:
                    self.main = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 3:
                if ftype == TType.STRING:
                    self.description = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 4:
                if ftype == TType.STRING:
                    self.icon = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
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
        oprot.writeStructBegin('Weather')
        if self.id is not None:
            oprot.writeFieldBegin('id', TType.I16, 1)
            oprot.writeI16(self.id)
            oprot.writeFieldEnd()
        if self.main is not None:
            oprot.writeFieldBegin('main', TType.STRING, 2)
            oprot.writeString(self.main.encode('utf-8') if sys.version_info[0] == 2 else self.main)
            oprot.writeFieldEnd()
        if self.description is not None:
            oprot.writeFieldBegin('description', TType.STRING, 3)
            oprot.writeString(self.description.encode('utf-8') if sys.version_info[0] == 2 else self.description)
            oprot.writeFieldEnd()
        if self.icon is not None:
            oprot.writeFieldBegin('icon', TType.STRING, 4)
            oprot.writeString(self.icon.encode('utf-8') if sys.version_info[0] == 2 else self.icon)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.id is None:
            raise TProtocolException(message='Required field id is unset!')
        if self.main is None:
            raise TProtocolException(message='Required field main is unset!')
        if self.description is None:
            raise TProtocolException(message='Required field description is unset!')
        if self.icon is None:
            raise TProtocolException(message='Required field icon is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)


class MainObject(object):
    """
    Attributes:
     - temp
     - feels_like
     - temp_min
     - temp_max
     - pressure
     - humidity

    """


    def __init__(self, temp=None, feels_like=None, temp_min=None, temp_max=None, pressure=None, humidity=None,):
        self.temp = temp
        self.feels_like = feels_like
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.humidity = humidity

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
                if ftype == TType.DOUBLE:
                    self.temp = iprot.readDouble()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.DOUBLE:
                    self.feels_like = iprot.readDouble()
                else:
                    iprot.skip(ftype)
            elif fid == 3:
                if ftype == TType.DOUBLE:
                    self.temp_min = iprot.readDouble()
                else:
                    iprot.skip(ftype)
            elif fid == 4:
                if ftype == TType.DOUBLE:
                    self.temp_max = iprot.readDouble()
                else:
                    iprot.skip(ftype)
            elif fid == 5:
                if ftype == TType.I16:
                    self.pressure = iprot.readI16()
                else:
                    iprot.skip(ftype)
            elif fid == 6:
                if ftype == TType.BYTE:
                    self.humidity = iprot.readByte()
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
        oprot.writeStructBegin('MainObject')
        if self.temp is not None:
            oprot.writeFieldBegin('temp', TType.DOUBLE, 1)
            oprot.writeDouble(self.temp)
            oprot.writeFieldEnd()
        if self.feels_like is not None:
            oprot.writeFieldBegin('feels_like', TType.DOUBLE, 2)
            oprot.writeDouble(self.feels_like)
            oprot.writeFieldEnd()
        if self.temp_min is not None:
            oprot.writeFieldBegin('temp_min', TType.DOUBLE, 3)
            oprot.writeDouble(self.temp_min)
            oprot.writeFieldEnd()
        if self.temp_max is not None:
            oprot.writeFieldBegin('temp_max', TType.DOUBLE, 4)
            oprot.writeDouble(self.temp_max)
            oprot.writeFieldEnd()
        if self.pressure is not None:
            oprot.writeFieldBegin('pressure', TType.I16, 5)
            oprot.writeI16(self.pressure)
            oprot.writeFieldEnd()
        if self.humidity is not None:
            oprot.writeFieldBegin('humidity', TType.BYTE, 6)
            oprot.writeByte(self.humidity)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.temp is None:
            raise TProtocolException(message='Required field temp is unset!')
        if self.feels_like is None:
            raise TProtocolException(message='Required field feels_like is unset!')
        if self.temp_min is None:
            raise TProtocolException(message='Required field temp_min is unset!')
        if self.temp_max is None:
            raise TProtocolException(message='Required field temp_max is unset!')
        if self.pressure is None:
            raise TProtocolException(message='Required field pressure is unset!')
        if self.humidity is None:
            raise TProtocolException(message='Required field humidity is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)


class Wind(object):
    """
    Attributes:
     - speed
     - deg

    """


    def __init__(self, speed=None, deg=None,):
        self.speed = speed
        self.deg = deg

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
                if ftype == TType.DOUBLE:
                    self.speed = iprot.readDouble()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.I16:
                    self.deg = iprot.readI16()
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
        oprot.writeStructBegin('Wind')
        if self.speed is not None:
            oprot.writeFieldBegin('speed', TType.DOUBLE, 1)
            oprot.writeDouble(self.speed)
            oprot.writeFieldEnd()
        if self.deg is not None:
            oprot.writeFieldBegin('deg', TType.I16, 2)
            oprot.writeI16(self.deg)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.speed is None:
            raise TProtocolException(message='Required field speed is unset!')
        if self.deg is None:
            raise TProtocolException(message='Required field deg is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)


class Clouds(object):
    """
    Attributes:
     - all

    """


    def __init__(self, all=None,):
        self.all = all

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
                if ftype == TType.BYTE:
                    self.all = iprot.readByte()
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
        oprot.writeStructBegin('Clouds')
        if self.all is not None:
            oprot.writeFieldBegin('all', TType.BYTE, 1)
            oprot.writeByte(self.all)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.all is None:
            raise TProtocolException(message='Required field all is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)


class Sys(object):
    """
    Attributes:
     - type
     - id
     - message
     - country
     - sunrise
     - sunset

    """


    def __init__(self, type=None, id=None, message=None, country=None, sunrise=None, sunset=None,):
        self.type = type
        self.id = id
        self.message = message
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset

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
                if ftype == TType.BYTE:
                    self.type = iprot.readByte()
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.I16:
                    self.id = iprot.readI16()
                else:
                    iprot.skip(ftype)
            elif fid == 3:
                if ftype == TType.DOUBLE:
                    self.message = iprot.readDouble()
                else:
                    iprot.skip(ftype)
            elif fid == 4:
                if ftype == TType.STRING:
                    self.country = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 5:
                if ftype == TType.I32:
                    self.sunrise = iprot.readI32()
                else:
                    iprot.skip(ftype)
            elif fid == 6:
                if ftype == TType.I32:
                    self.sunset = iprot.readI32()
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
        oprot.writeStructBegin('Sys')
        if self.type is not None:
            oprot.writeFieldBegin('type', TType.BYTE, 1)
            oprot.writeByte(self.type)
            oprot.writeFieldEnd()
        if self.id is not None:
            oprot.writeFieldBegin('id', TType.I16, 2)
            oprot.writeI16(self.id)
            oprot.writeFieldEnd()
        if self.message is not None:
            oprot.writeFieldBegin('message', TType.DOUBLE, 3)
            oprot.writeDouble(self.message)
            oprot.writeFieldEnd()
        if self.country is not None:
            oprot.writeFieldBegin('country', TType.STRING, 4)
            oprot.writeString(self.country.encode('utf-8') if sys.version_info[0] == 2 else self.country)
            oprot.writeFieldEnd()
        if self.sunrise is not None:
            oprot.writeFieldBegin('sunrise', TType.I32, 5)
            oprot.writeI32(self.sunrise)
            oprot.writeFieldEnd()
        if self.sunset is not None:
            oprot.writeFieldBegin('sunset', TType.I32, 6)
            oprot.writeI32(self.sunset)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.type is None:
            raise TProtocolException(message='Required field type is unset!')
        if self.id is None:
            raise TProtocolException(message='Required field id is unset!')
        if self.message is None:
            raise TProtocolException(message='Required field message is unset!')
        if self.country is None:
            raise TProtocolException(message='Required field country is unset!')
        if self.sunrise is None:
            raise TProtocolException(message='Required field sunrise is unset!')
        if self.sunset is None:
            raise TProtocolException(message='Required field sunset is unset!')
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
     - coord
     - weather
     - base
     - main
     - visibility
     - wind
     - clouds
     - dt
     - sys
     - timezone
     - id
     - name
     - cod

    """


    def __init__(self, coord=None, weather=None, base=None, main=None, visibility=None, wind=None, clouds=None, dt=None, sys=None, timezone=None, id=None, name=None, cod=None,):
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod

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
                if ftype == TType.STRUCT:
                    self.coord = Coord()
                    self.coord.read(iprot)
                else:
                    iprot.skip(ftype)
            elif fid == 2:
                if ftype == TType.LIST:
                    self.weather = []
                    (_etype3, _size0) = iprot.readListBegin()
                    for _i4 in range(_size0):
                        _elem5 = Weather()
                        _elem5.read(iprot)
                        self.weather.append(_elem5)
                    iprot.readListEnd()
                else:
                    iprot.skip(ftype)
            elif fid == 3:
                if ftype == TType.STRING:
                    self.base = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 4:
                if ftype == TType.STRUCT:
                    self.main = MainObject()
                    self.main.read(iprot)
                else:
                    iprot.skip(ftype)
            elif fid == 5:
                if ftype == TType.I16:
                    self.visibility = iprot.readI16()
                else:
                    iprot.skip(ftype)
            elif fid == 6:
                if ftype == TType.STRUCT:
                    self.wind = Wind()
                    self.wind.read(iprot)
                else:
                    iprot.skip(ftype)
            elif fid == 7:
                if ftype == TType.STRUCT:
                    self.clouds = Clouds()
                    self.clouds.read(iprot)
                else:
                    iprot.skip(ftype)
            elif fid == 8:
                if ftype == TType.I32:
                    self.dt = iprot.readI32()
                else:
                    iprot.skip(ftype)
            elif fid == 9:
                if ftype == TType.STRUCT:
                    self.sys = Sys()
                    self.sys.read(iprot)
                else:
                    iprot.skip(ftype)
            elif fid == 10:
                if ftype == TType.I32:
                    self.timezone = iprot.readI32()
                else:
                    iprot.skip(ftype)
            elif fid == 11:
                if ftype == TType.I32:
                    self.id = iprot.readI32()
                else:
                    iprot.skip(ftype)
            elif fid == 12:
                if ftype == TType.STRING:
                    self.name = iprot.readString().decode('utf-8') if sys.version_info[0] == 2 else iprot.readString()
                else:
                    iprot.skip(ftype)
            elif fid == 13:
                if ftype == TType.I16:
                    self.cod = iprot.readI16()
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
        if self.coord is not None:
            oprot.writeFieldBegin('coord', TType.STRUCT, 1)
            self.coord.write(oprot)
            oprot.writeFieldEnd()
        if self.weather is not None:
            oprot.writeFieldBegin('weather', TType.LIST, 2)
            oprot.writeListBegin(TType.STRUCT, len(self.weather))
            for iter6 in self.weather:
                iter6.write(oprot)
            oprot.writeListEnd()
            oprot.writeFieldEnd()
        if self.base is not None:
            oprot.writeFieldBegin('base', TType.STRING, 3)
            oprot.writeString(self.base.encode('utf-8') if sys.version_info[0] == 2 else self.base)
            oprot.writeFieldEnd()
        if self.main is not None:
            oprot.writeFieldBegin('main', TType.STRUCT, 4)
            self.main.write(oprot)
            oprot.writeFieldEnd()
        if self.visibility is not None:
            oprot.writeFieldBegin('visibility', TType.I16, 5)
            oprot.writeI16(self.visibility)
            oprot.writeFieldEnd()
        if self.wind is not None:
            oprot.writeFieldBegin('wind', TType.STRUCT, 6)
            self.wind.write(oprot)
            oprot.writeFieldEnd()
        if self.clouds is not None:
            oprot.writeFieldBegin('clouds', TType.STRUCT, 7)
            self.clouds.write(oprot)
            oprot.writeFieldEnd()
        if self.dt is not None:
            oprot.writeFieldBegin('dt', TType.I32, 8)
            oprot.writeI32(self.dt)
            oprot.writeFieldEnd()
        if self.sys is not None:
            oprot.writeFieldBegin('sys', TType.STRUCT, 9)
            self.sys.write(oprot)
            oprot.writeFieldEnd()
        if self.timezone is not None:
            oprot.writeFieldBegin('timezone', TType.I32, 10)
            oprot.writeI32(self.timezone)
            oprot.writeFieldEnd()
        if self.id is not None:
            oprot.writeFieldBegin('id', TType.I32, 11)
            oprot.writeI32(self.id)
            oprot.writeFieldEnd()
        if self.name is not None:
            oprot.writeFieldBegin('name', TType.STRING, 12)
            oprot.writeString(self.name.encode('utf-8') if sys.version_info[0] == 2 else self.name)
            oprot.writeFieldEnd()
        if self.cod is not None:
            oprot.writeFieldBegin('cod', TType.I16, 13)
            oprot.writeI16(self.cod)
            oprot.writeFieldEnd()
        oprot.writeFieldStop()
        oprot.writeStructEnd()

    def validate(self):
        if self.coord is None:
            raise TProtocolException(message='Required field coord is unset!')
        if self.weather is None:
            raise TProtocolException(message='Required field weather is unset!')
        if self.base is None:
            raise TProtocolException(message='Required field base is unset!')
        if self.main is None:
            raise TProtocolException(message='Required field main is unset!')
        if self.visibility is None:
            raise TProtocolException(message='Required field visibility is unset!')
        if self.wind is None:
            raise TProtocolException(message='Required field wind is unset!')
        if self.clouds is None:
            raise TProtocolException(message='Required field clouds is unset!')
        if self.dt is None:
            raise TProtocolException(message='Required field dt is unset!')
        if self.sys is None:
            raise TProtocolException(message='Required field sys is unset!')
        if self.timezone is None:
            raise TProtocolException(message='Required field timezone is unset!')
        if self.id is None:
            raise TProtocolException(message='Required field id is unset!')
        if self.name is None:
            raise TProtocolException(message='Required field name is unset!')
        if self.cod is None:
            raise TProtocolException(message='Required field cod is unset!')
        return

    def __repr__(self):
        L = ['%s=%r' % (key, value)
             for key, value in self.__dict__.items()]
        return '%s(%s)' % (self.__class__.__name__, ', '.join(L))

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.__dict__ == other.__dict__

    def __ne__(self, other):
        return not (self == other)
all_structs.append(Coord)
Coord.thrift_spec = (
    None,  # 0
    (1, TType.DOUBLE, 'lon', None, None, ),  # 1
    (2, TType.DOUBLE, 'lat', None, None, ),  # 2
)
all_structs.append(Weather)
Weather.thrift_spec = (
    None,  # 0
    (1, TType.I16, 'id', None, None, ),  # 1
    (2, TType.STRING, 'main', 'UTF8', None, ),  # 2
    (3, TType.STRING, 'description', 'UTF8', None, ),  # 3
    (4, TType.STRING, 'icon', 'UTF8', None, ),  # 4
)
all_structs.append(MainObject)
MainObject.thrift_spec = (
    None,  # 0
    (1, TType.DOUBLE, 'temp', None, None, ),  # 1
    (2, TType.DOUBLE, 'feels_like', None, None, ),  # 2
    (3, TType.DOUBLE, 'temp_min', None, None, ),  # 3
    (4, TType.DOUBLE, 'temp_max', None, None, ),  # 4
    (5, TType.I16, 'pressure', None, None, ),  # 5
    (6, TType.BYTE, 'humidity', None, None, ),  # 6
)
all_structs.append(Wind)
Wind.thrift_spec = (
    None,  # 0
    (1, TType.DOUBLE, 'speed', None, None, ),  # 1
    (2, TType.I16, 'deg', None, None, ),  # 2
)
all_structs.append(Clouds)
Clouds.thrift_spec = (
    None,  # 0
    (1, TType.BYTE, 'all', None, None, ),  # 1
)
all_structs.append(Sys)
Sys.thrift_spec = (
    None,  # 0
    (1, TType.BYTE, 'type', None, None, ),  # 1
    (2, TType.I16, 'id', None, None, ),  # 2
    (3, TType.DOUBLE, 'message', None, None, ),  # 3
    (4, TType.STRING, 'country', 'UTF8', None, ),  # 4
    (5, TType.I32, 'sunrise', None, None, ),  # 5
    (6, TType.I32, 'sunset', None, None, ),  # 6
)
all_structs.append(Main)
Main.thrift_spec = (
    None,  # 0
    (1, TType.STRUCT, 'coord', [Coord, None], None, ),  # 1
    (2, TType.LIST, 'weather', (TType.STRUCT, [Weather, None], False), None, ),  # 2
    (3, TType.STRING, 'base', 'UTF8', None, ),  # 3
    (4, TType.STRUCT, 'main', [MainObject, None], None, ),  # 4
    (5, TType.I16, 'visibility', None, None, ),  # 5
    (6, TType.STRUCT, 'wind', [Wind, None], None, ),  # 6
    (7, TType.STRUCT, 'clouds', [Clouds, None], None, ),  # 7
    (8, TType.I32, 'dt', None, None, ),  # 8
    (9, TType.STRUCT, 'sys', [Sys, None], None, ),  # 9
    (10, TType.I32, 'timezone', None, None, ),  # 10
    (11, TType.I32, 'id', None, None, ),  # 11
    (12, TType.STRING, 'name', 'UTF8', None, ),  # 12
    (13, TType.I16, 'cod', None, None, ),  # 13
)
fix_spec(all_structs)
del all_structs
