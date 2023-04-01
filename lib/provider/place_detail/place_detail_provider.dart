import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/models/place_detail/place_detail.dart';

final placeDetailProvider =
    StateNotifierProvider<PlaceDetailNotifier, List<PlaceDetail>>((ref) {
  return PlaceDetailNotifier([]);
});

class PlaceDetailNotifier extends StateNotifier<List<PlaceDetail>> {
  PlaceDetailNotifier(List<PlaceDetail> state) : super(state);
  void getPlaces() {
    FirebaseFirestore.instance.collection('shops').get().then((querySnapshot) {
      final places = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return PlaceDetail(
          id: doc.id,
          title: data['title'],
          imgURL: data['imgURL'],
          lat: data['lat'],
          long: data['long'],
          electronic: data['electronic'],
          ventilationFan: data['ventilationFan'],
          masticatory: data['masticatory'],
          situation: data['situation'],
          timezone: data['timezone'],
          seatforme: data['seatforme'],
        );
      }).toList();

      state = places;
    });
  }
}
