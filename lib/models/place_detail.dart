import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_detail.freezed.dart';
part 'place_detail.g.dart';

@freezed
class PlaceDetail with _$PlaceDetail {
  @JsonSerializable(explicitToJson: true) // ここに一行追加
  const factory PlaceDetail({
    @Default('') String title,
    @Default('') String author,
    @Default('') String imgURL,
  }) = _PlaceDetail;

  factory PlaceDetail.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailFromJson(json);
}
