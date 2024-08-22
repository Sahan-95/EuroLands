// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      nameDetails: NameDetails.fromJson(json['name'] as Map<String, dynamic>),
      capital:
          (json['capital'] as List<dynamic>).map((e) => e as String).toList(),
      flags: Flags.fromJson(json['flags'] as Map<String, dynamic>),
      region: json['region'] as String,
      languages: Map<String, String>.from(json['languages'] as Map),
      population: (json['population'] as num).toInt(),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.nameDetails,
      'capital': instance.capital,
      'flags': instance.flags,
      'region': instance.region,
      'languages': instance.languages,
      'population': instance.population,
    };

NameDetails _$NameDetailsFromJson(Map<String, dynamic> json) => NameDetails(
      common: json['common'] as String,
      official: json['official'] as String,
    );

Map<String, dynamic> _$NameDetailsToJson(NameDetails instance) =>
    <String, dynamic>{
      'common': instance.common,
      'official': instance.official,
    };

Flags _$FlagsFromJson(Map<String, dynamic> json) => Flags(
      png: json['png'] as String,
      svg: json['svg'] as String,
      alt: json['alt'] as String,
    );

Map<String, dynamic> _$FlagsToJson(Flags instance) => <String, dynamic>{
      'png': instance.png,
      'svg': instance.svg,
      'alt': instance.alt,
    };
