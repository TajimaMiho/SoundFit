import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_detail.freezed.dart';
part 'place_detail.g.dart';

@freezed
class PlaceDetail with _$PlaceDetail {
  @JsonSerializable(explicitToJson: true)
  const factory PlaceDetail({
    @Default('') String id,
    @Default('') String title,
    @Default('') String imgURL,
    @Default(0) double lat,
    @Default(0) double long,
    @Default(0) int electronic,
    @Default(0) int ventilationFan,
    @Default(0) int masticatory,
    @Default('') String timezone,
    @Default('') String situation,
    @Default('') String seatforme,
  }) = _PlaceDetail;

  factory PlaceDetail.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailFromJson(json);
}
