import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherNow {
  static final statusMessageMap = {
    "200": '请求成功',
    "204": '请求成功，但你查询的地区暂时没有你需要的数据',
    "400": '请求错误，可能包含错误的请求参数或缺少必选的请求参数',
    "401": '认证失败，可能使用了错误的KEY、数字签名错误、KEY的类型错误',
    "402": '超过访问次数或余额不足以支持继续访问服务，你可以充值、升级访问量或等待访问量重置',
    "403": '无访问权限，可能是绑定的PackageName、BundleID、域名IP地址不一致，或者是需要额外付费的数据',
    "404": '查询的数据或地区不存在',
    "429": '超过限定的QPM（每分钟访问次数）',
    "500": '无响应或超时，接口服务异常',
  };

  static String parseStatusCode(dynamic code) {
    if (code is int || code is String) {
      return statusMessageMap[code.toString()] ?? "Unknown error";
    } else {
      return "";
    }
  }

  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'updateTime')
  final String? updatetime;
  @JsonKey(name: 'fxLink')
  final String? fxlink;
  @JsonKey(name: 'now')
  final Now? now;
  @JsonKey(name: 'refer')
  final Refer? refer;
  WeatherNow(
      {required this.code, this.updatetime, this.fxlink, this.now, this.refer});
  factory WeatherNow.fromJson(Map<String, dynamic> json) =>
      _$WeatherNowFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherNowToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Refer {
  @JsonKey(name: 'sources')
  final List<String> sources;
  @JsonKey(name: 'license')
  final List<String> license;
  Refer({required this.sources, required this.license});
  factory Refer.fromJson(Map<String, dynamic> json) => _$ReferFromJson(json);
  Map<String, dynamic> toJson() => _$ReferToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Now {
  @JsonKey(name: 'obsTime')
  final String obstime;
  @JsonKey(name: 'temp')
  final String temp;
  @JsonKey(name: 'feelsLike')
  final String feelslike;
  @JsonKey(name: 'icon')
  final String icon;
  @JsonKey(name: 'text')
  final String text;
  @JsonKey(name: 'wind360')
  final String wind360;
  @JsonKey(name: 'windDir')
  final String winddir;
  @JsonKey(name: 'windScale')
  final String windscale;
  @JsonKey(name: 'windSpeed')
  final String windspeed;
  @JsonKey(name: 'humidity')
  final String humidity;
  @JsonKey(name: 'precip')
  final String precip;
  @JsonKey(name: 'pressure')
  final String pressure;
  @JsonKey(name: 'vis')
  final String vis;
  @JsonKey(name: 'cloud')
  final String cloud;
  @JsonKey(name: 'dew')
  final String dew;
  Now(
      {required this.obstime,
      required this.temp,
      required this.feelslike,
      required this.icon,
      required this.text,
      required this.wind360,
      required this.winddir,
      required this.windscale,
      required this.windspeed,
      required this.humidity,
      required this.precip,
      required this.pressure,
      required this.vis,
      required this.cloud,
      required this.dew});
  factory Now.fromJson(Map<String, dynamic> json) => _$NowFromJson(json);
  Map<String, dynamic> toJson() => _$NowToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherHour {
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'updateTime')
  final String? updatetime;
  @JsonKey(name: 'fxLink')
  final String? fxlink;
  @JsonKey(name: 'hourly')
  final List<Hourly>? hourly;
  @JsonKey(name: 'refer')
  final Refer? refer;
  WeatherHour(
      {required this.code,
      this.updatetime,
      this.fxlink,
      this.hourly,
      this.refer});
  factory WeatherHour.fromJson(Map<String, dynamic> json) =>
      _$WeatherHourFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherHourToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Hourly {
  @JsonKey(name: 'fxTime')
  final String fxtime;
  @JsonKey(name: 'temp')
  final String temp;
  @JsonKey(name: 'icon')
  final String icon;
  @JsonKey(name: 'text')
  final String text;
  @JsonKey(name: 'wind360')
  final String wind360;
  @JsonKey(name: 'windDir')
  final String winddir;
  @JsonKey(name: 'windScale')
  final String windscale;
  @JsonKey(name: 'windSpeed')
  final String windspeed;
  @JsonKey(name: 'humidity')
  final String humidity;
  @JsonKey(name: 'pop')
  final String pop;
  @JsonKey(name: 'precip')
  final String precip;
  @JsonKey(name: 'pressure')
  final String pressure;
  @JsonKey(name: 'cloud')
  final String cloud;
  @JsonKey(name: 'dew')
  final String dew;
  Hourly(
      {required this.fxtime,
      required this.temp,
      required this.icon,
      required this.text,
      required this.wind360,
      required this.winddir,
      required this.windscale,
      required this.windspeed,
      required this.humidity,
      required this.pop,
      required this.precip,
      required this.pressure,
      required this.cloud,
      required this.dew});
  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}

class Daily {
  String? fxDate;
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonPhaseIcon;
  String? tempMax;
  String? tempMin;
  String? iconDay;
  String? textDay;
  String? iconNight;
  String? textNight;
  String? wind360Day;
  String? windDirDay;
  String? windScaleDay;
  String? windSpeedDay;
  String? wind360Night;
  String? windDirNight;
  String? windScaleNight;
  String? windSpeedNight;
  String? humidity;
  String? precip;
  String? pressure;
  String? vis;
  String? cloud;
  String? uvIndex;

  Daily(
      {this.fxDate,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.moonPhaseIcon,
      this.tempMax,
      this.tempMin,
      this.iconDay,
      this.textDay,
      this.iconNight,
      this.textNight,
      this.wind360Day,
      this.windDirDay,
      this.windScaleDay,
      this.windSpeedDay,
      this.wind360Night,
      this.windDirNight,
      this.windScaleNight,
      this.windSpeedNight,
      this.humidity,
      this.precip,
      this.pressure,
      this.vis,
      this.cloud,
      this.uvIndex});

  Daily.fromJson(Map<String, dynamic> json) {
    fxDate = json['fxDate'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moonPhase'];
    moonPhaseIcon = json['moonPhaseIcon'];
    tempMax = json['tempMax'];
    tempMin = json['tempMin'];
    iconDay = json['iconDay'];
    textDay = json['textDay'];
    iconNight = json['iconNight'];
    textNight = json['textNight'];
    wind360Day = json['wind360Day'];
    windDirDay = json['windDirDay'];
    windScaleDay = json['windScaleDay'];
    windSpeedDay = json['windSpeedDay'];
    wind360Night = json['wind360Night'];
    windDirNight = json['windDirNight'];
    windScaleNight = json['windScaleNight'];
    windSpeedNight = json['windSpeedNight'];
    humidity = json['humidity'];
    precip = json['precip'];
    pressure = json['pressure'];
    vis = json['vis'];
    cloud = json['cloud'];
    uvIndex = json['uvIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fxDate'] = fxDate;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['moonrise'] = moonrise;
    data['moonset'] = moonset;
    data['moonPhase'] = moonPhase;
    data['moonPhaseIcon'] = moonPhaseIcon;
    data['tempMax'] = tempMax;
    data['tempMin'] = tempMin;
    data['iconDay'] = iconDay;
    data['textDay'] = textDay;
    data['iconNight'] = iconNight;
    data['textNight'] = textNight;
    data['wind360Day'] = wind360Day;
    data['windDirDay'] = windDirDay;
    data['windScaleDay'] = windScaleDay;
    data['windSpeedDay'] = windSpeedDay;
    data['wind360Night'] = wind360Night;
    data['windDirNight'] = windDirNight;
    data['windScaleNight'] = windScaleNight;
    data['windSpeedNight'] = windSpeedNight;
    data['humidity'] = humidity;
    data['precip'] = precip;
    data['pressure'] = pressure;
    data['vis'] = vis;
    data['cloud'] = cloud;
    data['uvIndex'] = uvIndex;
    return data;
  }
}

class WeatherDaily {
  String? code;
  String? updateTime;
  String? fxLink;
  List<Daily?>? daily;
  Refer? refer;

  WeatherDaily(
      {this.code, this.updateTime, this.fxLink, this.daily, this.refer});

  WeatherDaily.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    updateTime = json['updateTime'];
    fxLink = json['fxLink'];
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily!.add(Daily.fromJson(v));
      });
    }
    refer = json['refer'] != null ? Refer?.fromJson(json['refer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['updateTime'] = updateTime;
    data['fxLink'] = fxLink;
    data['daily'] = daily?.map((v) => v?.toJson()).toList();
    data['refer'] = refer!.toJson();
    return data;
  }
}
