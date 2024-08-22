import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class Country {
  @JsonKey(name: 'name')
  final NameDetails nameDetails;

  @JsonKey(name: 'capital')
  final List<String> capital;

  @JsonKey(name: 'flags')
  final Flags flags;

  @JsonKey(name: 'region')
  final String region;

  @JsonKey(name: 'languages')
  final Map<String, String> languages;

  @JsonKey(name: 'population')
  final int population;

  Country({
    required this.nameDetails,
    required this.capital,
    required this.flags,
    required this.region,
    required this.languages,
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class NameDetails {
  @JsonKey(name: 'common')
  final String common;

  @JsonKey(name: 'official')
  final String official;

  NameDetails({
    required this.common,
    required this.official,
  });

  factory NameDetails.fromJson(Map<String, dynamic> json) => _$NameDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$NameDetailsToJson(this);
}

@JsonSerializable()
class Flags {
  @JsonKey(name: 'png')
  final String png;

  @JsonKey(name: 'svg')
  final String svg;

  @JsonKey(name: 'alt')
  final String alt;

  Flags({
    required this.png,
    required this.svg,
    required this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);
  Map<String, dynamic> toJson() => _$FlagsToJson(this);
}
