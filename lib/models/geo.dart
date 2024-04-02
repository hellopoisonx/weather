import 'package:json_annotation/json_annotation.dart';

part 'geo.g.dart';

@JsonSerializable(explicitToJson: true)
class Geo {
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'location')
  final List<Location>? location;
  @JsonKey(name: 'refer')
  final Refer? refer;
  Geo({required this.code, this.location, this.refer});
  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
  Map<String, dynamic> toJson() => _$GeoToJson(this);
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
class Location {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'lat')
  final String lat;
  @JsonKey(name: 'lon')
  final String lon;
  @JsonKey(name: 'adm2')
  final String adm2;
  @JsonKey(name: 'adm1')
  final String adm1;
  @JsonKey(name: 'country')
  final String country;
  @JsonKey(name: 'tz')
  final String tz;
  @JsonKey(name: 'utcOffset')
  final String utcoffset;
  @JsonKey(name: 'isDst')
  final String isdst;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'rank')
  final String rank;
  @JsonKey(name: 'fxLink')
  final String fxlink;
  Location(
      {required this.name,
      required this.id,
      required this.lat,
      required this.lon,
      required this.adm2,
      required this.adm1,
      required this.country,
      required this.tz,
      required this.utcoffset,
      required this.isdst,
      required this.type,
      required this.rank,
      required this.fxlink});
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
