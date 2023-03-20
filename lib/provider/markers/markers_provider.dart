import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycloud/models/place/place_model.dart';
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

final markersProvider =
    StateNotifierProvider<MarkersNotifier, List<Marker>>((ref) {
  return MarkersNotifier([]);
});

class MarkersNotifier extends StateNotifier<List<Marker>> {
  MarkersNotifier(List<Marker> state) : super(state);

  void addMarkers(List<PlaceModel> places) {
    var newMarkers = places.map((place) {
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
}
