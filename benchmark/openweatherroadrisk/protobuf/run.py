def encode(json, schema):
    payload = schema.Main()

    print(json)

    risk1 = payload.risks.add()
    risk1.dt = json['risks'][0]['dt']
    risk1.coord.extend(json['risks'][0]['coord'])
    risk1.weather.temp = json['risks'][0]['weather']['temp']
    risk1.weather.wind_speed = json['risks'][0]['weather']['wind_speed']
    risk1.weather.wind_deg = json['risks'][0]['weather']['wind_deg']
    risk1.weather.precipitation_intensity = \
        json['risks'][0]['weather']['precipitation_intensity']
    risk1.weather.dew_point = json['risks'][0]['weather']['dew_point']

    alert1 = risk1.alerts.add()
    alert1.sender_name = json['risks'][0]['alerts'][0]['sender_name']
    alert1.event = json['risks'][0]['alerts'][0]['event']
    alert1.event_level = json['risks'][0]['alerts'][0]['event_level']

    risk2 = payload.risks.add()
    risk2.dt = json['risks'][1]['dt']
    risk2.coord.extend(json['risks'][1]['coord'])

    risk2.weather.temp = json['risks'][1]['weather']['temp']
    risk2.weather.wind_speed = json['risks'][1]['weather']['wind_speed']
    risk2.weather.wind_deg = json['risks'][1]['weather']['wind_deg']
    risk2.weather.dew_point = json['risks'][1]['weather']['dew_point']

    return payload


def decode(payload):
    return {
      'risks': [
        {
          'dt': payload.risks[0].dt,
          'coord': list(payload.risks[0].coord),
          'weather': {
            'temp': payload.risks[0].weather.temp,
            'wind_speed': payload.risks[0].weather.wind_speed,
            'wind_deg': payload.risks[0].weather.wind_deg,
            'precipitation_intensity':
            payload.risks[0].weather.precipitation_intensity,
            'dew_point': payload.risks[0].weather.dew_point
          },
          'alerts': [
            {
              'sender_name': payload.risks[0].alerts[0].sender_name,
              'event': payload.risks[0].alerts[0].event,
              'event_level': payload.risks[0].alerts[0].event_level
            }
          ]
        },
        {
          'dt': payload.risks[1].dt,
          'coord': list(payload.risks[1].coord),
          'weather': {
            'temp': payload.risks[1].weather.temp,
            'wind_speed': payload.risks[1].weather.wind_speed,
            'wind_deg': payload.risks[1].weather.wind_deg,
            'dew_point': payload.risks[1].weather.dew_point
          },
          'alerts': list(payload.risks[1].alerts)
        }
      ]
    }
