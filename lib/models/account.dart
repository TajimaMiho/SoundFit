import 'package:freezed_annotation/freezed_annotation.dart';
part 'account.freezed.dart';

@freezed
class Account with _$Account {
  @JsonSerializable(explicitToJson: true) // ここに一行追加
  const factory Account({
    @Default('') String name,
  }) = _Account;
}
