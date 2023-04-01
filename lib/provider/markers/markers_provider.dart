import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycloud/models/place/place_model.dart';
import 'package:mycloud/view/top/add/places_page/places_page.dart';

final markersProvider =
    StateNotifierProvider<MarkersNotifier, List<Marker>>((ref) {
  return MarkersNotifier([]);
});

class MarkersNotifier extends StateNotifier<List<Marker>> {
  MarkersNotifier(List<Marker> state) : super(state);

  Future<void> addMarkers(BuildContext context, List<PlaceModel> places) async {
    final newMarkers = places.map((place) {
      return Marker(
        markerId: MarkerId('${place.lat}-${place.long}'),
        position: LatLng(place.lat, place.long),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShopListPage(
                lat: place.lat,
                long: place.long,
                shoptitle: 'どこか',
              ),
            ),
          );
        },
      );
    }).toList();

    state = newMarkers;
  }

  void clearMarkers() {
    state = [];
  }
}

//import 'package:freezed_annotation/freezed_annotation.dart';
//part 'markers_provider.freezed.dart';

/*@freezed
class MarkersState with _$MarkersState {
  const factory MarkersState({
    @Default(List<PlaceModel>) List<PlaceModel> markers,
  }) = _MarkersState;
}

final markersProvider =
    StateNotifierProvider<MarkersNotifier, MarkersState>((ref) {
  return MarkersNotifier(places: []);
});

class MarkersNotifier extends StateNotifier<MarkersState> {
  MarkersNotifier({required List<PlaceModel> places})
      : _places = places,
        super(MarkersState()) {
    addMarkers(places);
  }
  final List<PlaceModel> _places;

  void addMarkers(places) {
    final newMarkers = places.map((place) {
      return Marker(
        markerId: MarkerId('${place.lat}-${place.long}'),
        position: LatLng(place.lat, place.long),
      );
    }).toList();

    state = state.copyWith(markers: newMarkers);
  }

  void clearMarkers() {
    state = [] as MarkersState;
  }
}*/

//MarkersNotifier(List<Marker> state) : super(state);

/*
final markersProvider =
    StateNotifierProvider<MarkersNotifier, List<Marker>>((ref) {
  return MarkersNotifier([]);
});

class MarkersNotifier extends StateNotifier<List<Marker>> {
  MarkersNotifier(List<Marker> state) : super(state);

  void addMarkers() async {
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

    state = newMarkers;
  }

  void clearMarkers() {
    state = [];
  }
}*/
