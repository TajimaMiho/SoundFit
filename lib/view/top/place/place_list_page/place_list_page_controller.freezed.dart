// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'place_list_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShopListPageState {
  Shop get shop => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShopListPageStateCopyWith<ShopListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopListPageStateCopyWith<$Res> {
  factory $ShopListPageStateCopyWith(
          ShopListPageState value, $Res Function(ShopListPageState) then) =
      _$ShopListPageStateCopyWithImpl<$Res, ShopListPageState>;
  @useResult
  $Res call({Shop shop});

  $ShopCopyWith<$Res> get shop;
}

/// @nodoc
class _$ShopListPageStateCopyWithImpl<$Res, $Val extends ShopListPageState>
    implements $ShopListPageStateCopyWith<$Res> {
  _$ShopListPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shop = null,
  }) {
    return _then(_value.copyWith(
      shop: null == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ShopCopyWith<$Res> get shop {
    return $ShopCopyWith<$Res>(_value.shop, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ShopListPageStateCopyWith<$Res>
    implements $ShopListPageStateCopyWith<$Res> {
  factory _$$_ShopListPageStateCopyWith(_$_ShopListPageState value,
          $Res Function(_$_ShopListPageState) then) =
      __$$_ShopListPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Shop shop});

  @override
  $ShopCopyWith<$Res> get shop;
}

/// @nodoc
class __$$_ShopListPageStateCopyWithImpl<$Res>
    extends _$ShopListPageStateCopyWithImpl<$Res, _$_ShopListPageState>
    implements _$$_ShopListPageStateCopyWith<$Res> {
  __$$_ShopListPageStateCopyWithImpl(
      _$_ShopListPageState _value, $Res Function(_$_ShopListPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shop = null,
  }) {
    return _then(_$_ShopListPageState(
      shop: null == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop,
    ));
  }
}

/// @nodoc

class _$_ShopListPageState implements _ShopListPageState {
  const _$_ShopListPageState({this.shop = Shop()});

  @override
  @JsonKey()
  final Shop shop;

  @override
  String toString() {
    return 'ShopListPageState(shop: $shop)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShopListPageState &&
            (identical(other.shop, shop) || other.shop == shop));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shop);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShopListPageStateCopyWith<_$_ShopListPageState> get copyWith =>
      __$$_ShopListPageStateCopyWithImpl<_$_ShopListPageState>(
          this, _$identity);
}

abstract class _ShopListPageState implements ShopListPageState {
  const factory _ShopListPageState({final Shop shop}) = _$_ShopListPageState;

  @override
  Shop get shop;
  @override
  @JsonKey(ignore: true)
  _$$_ShopListPageStateCopyWith<_$_ShopListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
