// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherNow _$WeatherNowFromJson(Map<String, dynamic> json) => WeatherNow(
      code: json['code'] as String,
      updatetime: json['updateTime'] as String?,
      fxlink: json['fxLink'] as String?,
      now: json['now'] == null
          ? null
          : Now.fromJson(json['now'] as Map<String, dynamic>),
      refer: json['refer'] == null
          ? null
          : Refer.fromJson(json['refer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherNowToJson(WeatherNow instance) =>
    <String, dynamic>{
      'code': instance.code,
      'updateTime': instance.updatetime,
      'fxLink': instance.fxlink,
      'now': instance.now?.toJson(),
      'refer': instance.refer?.toJson(),
    };

Refer _$ReferFromJson(Map<String, dynamic> json) => Refer(
      sources:
          (json['sources'] as List<dynamic>).map((e) => e as String).toList(),
      license:
          (json['license'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ReferToJson(Refer instance) => <String, dynamic>{
      'sources': instance.sources,
      'license': instance.license,
    };

Now _$NowFromJson(Map<String, dynamic> json) => Now(
      obstime: json['obsTime'] as String,
      temp: json['temp'] as String,
      feelslike: json['feelsLike'] as String,
      icon: json['icon'] as String,
      text: json['text'] as String,
      wind360: json['wind360'] as String,
      winddir: json['windDir'] as String,
      windscale: json['windScale'] as String,
      windspeed: json['windSpeed'] as String,
      humidity: json['humidity'] as String,
      precip: json['precip'] as String,
      pressure: json['pressure'] as String,
      vis: json['vis'] as String,
      cloud: json['cloud'] as String,
      dew: json['dew'] as String,
    );

Map<String, dynamic> _$NowToJson(Now instance) => <String, dynamic>{
      'obsTime': instance.obstime,
      'temp': instance.temp,
      'feelsLike': instance.feelslike,
      'icon': instance.icon,
      'text': instance.text,
      'wind360': instance.wind360,
      'windDir': instance.winddir,
      'windScale': instance.windscale,
      'windSpeed': instance.windspeed,
      'humidity': instance.humidity,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'vis': instance.vis,
      'cloud': instance.cloud,
      'dew': instance.dew,
    };

WeatherHour _$WeatherHourFromJson(Map<String, dynamic> json) => WeatherHour(
      code: json['code'] as String,
      updatetime: json['updateTime'] as String?,
      fxlink: json['fxLink'] as String?,
      hourly: (json['hourly'] as List<dynamic>?)
          ?.map((e) => Hourly.fromJson(e as Map<String, dynamic>))
          .toList(),
      refer: json['refer'] == null
          ? null
          : Refer.fromJson(json['refer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherHourToJson(WeatherHour instance) =>
    <String, dynamic>{
      'code': instance.code,
      'updateTime': instance.updatetime,
      'fxLink': instance.fxlink,
      'hourly': instance.hourly?.map((e) => e.toJson()).toList(),
      'refer': instance.refer?.toJson(),
    };

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
      fxtime: json['fxTime'] as String,
      temp: json['temp'] as String,
      icon: json['icon'] as String,
      text: json['text'] as String,
      wind360: json['wind360'] as String,
      winddir: json['windDir'] as String,
      windscale: json['windScale'] as String,
      windspeed: json['windSpeed'] as String,
      humidity: json['humidity'] as String,
      pop: json['pop'] as String,
      precip: json['precip'] as String,
      pressure: json['pressure'] as String,
      cloud: json['cloud'] as String,
      dew: json['dew'] as String,
    );

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'fxTime': instance.fxtime,
      'temp': instance.temp,
      'icon': instance.icon,
      'text': instance.text,
      'wind360': instance.wind360,
      'windDir': instance.winddir,
      'windScale': instance.windscale,
      'windSpeed': instance.windspeed,
      'humidity': instance.humidity,
      'pop': instance.pop,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'cloud': instance.cloud,
      'dew': instance.dew,
    };
