import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/models/place_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'place_detail_controller.freezed.dart';

@freezed
class PlaceDetailState with _$PlaceDetailState {
  const factory PlaceDetailState({
    @Default(PlaceDetail()) PlaceDetail placeDetail,
  }) = _PlaceDetailState;
}

/*final placeDetailProvider =
    StateNotifierProvider<PlaceDetailStateProvider, PlaceDetailState>(
  (ref) => PlaceDetailStateProvider(
    ref,
  ),
);

class PlaceDetailStateProvider extends StateNotifier<PlaceDetailState> {
  PlaceDetailStateProvider(this._reader) : super(const PlaceDetailState()) {
    init();
  }

  final firePlaceDetailService = FirePlaceDetailService(shopId: shopId);

  Future<void> init() async {
    String email = _reader.watch(loginProvider).user.email;
    final fetchedPlaceDetail =
        await firePlaceDetailService.fetchPlaceDetail(email);
    state = state.copyWith(placeDetail: fetchedPlaceDetail);
  }

  void updatePlaceDetail(PlaceDetail placeDetail) {
    state = state.copyWith(placeDetail: placeDetail);
  }

  final StateNotifierProviderRef _reader;
}*/

class FirePlaceDetailService {
  final _fireStore = FirebaseFirestore.instance;
  final String shopId;
  FirePlaceDetailService({required this.shopId});

  Future<PlaceDetail> fetchPlaceDetail(String id) async {
    id = shopId;
    final document =
        await FirebaseFirestore.instance.collection('shops').doc(id).get();

    return const PlaceDetail()
        .copyWith(title: document['title'], imgURL: document['imgURL']);
  }
}
