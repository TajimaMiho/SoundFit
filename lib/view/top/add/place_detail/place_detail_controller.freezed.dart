// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'place_detail_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlaceDetailState {
  PlaceDetail get placeDetail => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaceDetailStateCopyWith<PlaceDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceDetailStateCopyWith<$Res> {
  factory $PlaceDetailStateCopyWith(
          PlaceDetailState value, $Res Function(PlaceDetailState) then) =
      _$PlaceDetailStateCopyWithImpl<$Res, PlaceDetailState>;
  @useResult
  $Res call({PlaceDetail placeDetail});

  $PlaceDetailCopyWith<$Res> get placeDetail;
}

/// @nodoc
class _$PlaceDetailStateCopyWithImpl<$Res, $Val extends PlaceDetailState>
    implements $PlaceDetailStateCopyWith<$Res> {
  _$PlaceDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeDetail = null,
  }) {
    return _then(_value.copyWith(
      placeDetail: null == placeDetail
          ? _value.placeDetail
          : placeDetail // ignore: cast_nullable_to_non_nullable
              as PlaceDetail,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlaceDetailCopyWith<$Res> get placeDetail {
    return $PlaceDetailCopyWith<$Res>(_value.placeDetail, (value) {
      return _then(_value.copyWith(placeDetail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PlaceDetailStateCopyWith<$Res>
    implements $PlaceDetailStateCopyWith<$Res> {
  factory _$$_PlaceDetailStateCopyWith(
          _$_PlaceDetailState value, $Res Function(_$_PlaceDetailState) then) =
      __$$_PlaceDetailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlaceDetail placeDetail});

  @override
  $PlaceDetailCopyWith<$Res> get placeDetail;
}

/// @nodoc
class __$$_PlaceDetailStateCopyWithImpl<$Res>
    extends _$PlaceDetailStateCopyWithImpl<$Res, _$_PlaceDetailState>
    implements _$$_PlaceDetailStateCopyWith<$Res> {
  __$$_PlaceDetailStateCopyWithImpl(
      _$_PlaceDetailState _value, $Res Function(_$_PlaceDetailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeDetail = null,
  }) {
    return _then(_$_PlaceDetailState(
      placeDetail: null == placeDetail
          ? _value.placeDetail
          : placeDetail // ignore: cast_nullable_to_non_nullable
              as PlaceDetail,
    ));
  }
}

/// @nodoc

class _$_PlaceDetailState implements _PlaceDetailState {
  const _$_PlaceDetailState({this.placeDetail = const PlaceDetail()});

  @override
  @JsonKey()
  final PlaceDetail placeDetail;

  @override
  String toString() {
    return 'PlaceDetailState(placeDetail: $placeDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlaceDetailState &&
            (identical(other.placeDetail, placeDetail) ||
                other.placeDetail == placeDetail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, placeDetail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlaceDetailStateCopyWith<_$_PlaceDetailState> get copyWith =>
      __$$_PlaceDetailStateCopyWithImpl<_$_PlaceDetailState>(this, _$identity);
}

abstract class _PlaceDetailState implements PlaceDetailState {
  const factory _PlaceDetailState({final PlaceDetail placeDetail}) =
      _$_PlaceDetailState;

  @override
  PlaceDetail get placeDetail;
  @override
  @JsonKey(ignore: true)
  _$$_PlaceDetailStateCopyWith<_$_PlaceDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}
