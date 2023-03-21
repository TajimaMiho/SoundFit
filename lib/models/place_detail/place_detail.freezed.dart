// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'place_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlaceDetail _$PlaceDetailFromJson(Map<String, dynamic> json) {
  return _PlaceDetail.fromJson(json);
}

/// @nodoc
mixin _$PlaceDetail {
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get imgURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaceDetailCopyWith<PlaceDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceDetailCopyWith<$Res> {
  factory $PlaceDetailCopyWith(
          PlaceDetail value, $Res Function(PlaceDetail) then) =
      _$PlaceDetailCopyWithImpl<$Res, PlaceDetail>;
  @useResult
  $Res call({String title, String author, String imgURL});
}

/// @nodoc
class _$PlaceDetailCopyWithImpl<$Res, $Val extends PlaceDetail>
    implements $PlaceDetailCopyWith<$Res> {
  _$PlaceDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? author = null,
    Object? imgURL = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      imgURL: null == imgURL
          ? _value.imgURL
          : imgURL // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlaceDetailCopyWith<$Res>
    implements $PlaceDetailCopyWith<$Res> {
  factory _$$_PlaceDetailCopyWith(
          _$_PlaceDetail value, $Res Function(_$_PlaceDetail) then) =
      __$$_PlaceDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String author, String imgURL});
}

/// @nodoc
class __$$_PlaceDetailCopyWithImpl<$Res>
    extends _$PlaceDetailCopyWithImpl<$Res, _$_PlaceDetail>
    implements _$$_PlaceDetailCopyWith<$Res> {
  __$$_PlaceDetailCopyWithImpl(
      _$_PlaceDetail _value, $Res Function(_$_PlaceDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? author = null,
    Object? imgURL = null,
  }) {
    return _then(_$_PlaceDetail(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      imgURL: null == imgURL
          ? _value.imgURL
          : imgURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PlaceDetail implements _PlaceDetail {
  const _$_PlaceDetail({this.title = '', this.author = '', this.imgURL = ''});

  factory _$_PlaceDetail.fromJson(Map<String, dynamic> json) =>
      _$$_PlaceDetailFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String author;
  @override
  @JsonKey()
  final String imgURL;

  @override
  String toString() {
    return 'PlaceDetail(title: $title, author: $author, imgURL: $imgURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlaceDetail &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.imgURL, imgURL) || other.imgURL == imgURL));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, author, imgURL);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlaceDetailCopyWith<_$_PlaceDetail> get copyWith =>
      __$$_PlaceDetailCopyWithImpl<_$_PlaceDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaceDetailToJson(
      this,
    );
  }
}

abstract class _PlaceDetail implements PlaceDetail {
  const factory _PlaceDetail(
      {final String title,
      final String author,
      final String imgURL}) = _$_PlaceDetail;

  factory _PlaceDetail.fromJson(Map<String, dynamic> json) =
      _$_PlaceDetail.fromJson;

  @override
  String get title;
  @override
  String get author;
  @override
  String get imgURL;
  @override
  @JsonKey(ignore: true)
  _$$_PlaceDetailCopyWith<_$_PlaceDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
