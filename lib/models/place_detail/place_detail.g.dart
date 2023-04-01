// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlaceDetail _$$_PlaceDetailFromJson(Map<String, dynamic> json) =>
    _$_PlaceDetail(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imgURL: json['imgURL'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      long: (json['long'] as num?)?.toDouble() ?? 0,
      electronic: json['electronic'] as int? ?? 0,
      ventilationFan: json['ventilationFan'] as int? ?? 0,
      masticatory: json['masticatory'] as int? ?? 0,
      timezone: json['timezone'] as String? ?? '',
      situation: json['situation'] as String? ?? '',
      seatforme: json['seatforme'] as String? ?? '',
    );

Map<String, dynamic> _$$_PlaceDetailToJson(_$_PlaceDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imgURL': instance.imgURL,
      'lat': instance.lat,
      'long': instance.long,
      'electronic': instance.electronic,
      'ventilationFan': instance.ventilationFan,
      'masticatory': instance.masticatory,
      'timezone': instance.timezone,
      'situation': instance.situation,
      'seatforme': instance.seatforme,
    };
