import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycloud/models/place/place_model.dart';

/*final placeModelProvider =
    FutureProvider.autoDispose<List<Marker>>((ref) async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('places').get();

  final places = querySnapshot.docs.map((doc) {
    final data = doc.data();
    return PlaceModel(
      lat: data['lat'],
      long: data['long'],
    );
  }).toList();

  final newMarkers = places.map((place) {
    return Marker(
      markerId: MarkerId('${place.lat}-${place.long}'),
      position: LatLng(place.lat, place.long),
    );
  }).toList();

  return newMarkers;
});*/

final placeModelProvider =
    StateNotifierProvider<PlaceModelNotifier, List<PlaceModel>>((ref) {
  return PlaceModelNotifier([]);
});

class PlaceModelNotifier extends StateNotifier<List<PlaceModel>> {
  PlaceModelNotifier(List<PlaceModel> state) : super(state);
  void getPlaces() {
    FirebaseFirestore.instance.collection('places').get().then((querySnapshot) {
      final places = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return PlaceModel(
          lat: data['lat'],
          long: data['long'],
        );
      }).toList();

      state = places;
    });
  }
}

/*final placeModelProvider =
    FutureProvider.autoDispose<List<PlaceModel>>((ref) async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('places').get();

  final places = querySnapshot.docs.map((doc) {
    final data = doc.data();
    return PlaceModel(
      lat: data['lat'],
      long: data['long'],
    );
  }).toList();

  return places;
});*/
