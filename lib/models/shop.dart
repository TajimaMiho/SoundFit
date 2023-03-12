import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class Shop with _$Shop {
  @JsonSerializable(explicitToJson: true) // ここに一行追加
  const factory Shop({
    @Default('') String id,
    @Default('') String title,
    @Default('') String author,
    @Default('') String imgURL,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}
