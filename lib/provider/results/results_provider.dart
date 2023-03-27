import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

GooglePlace _googlePlace =
    GooglePlace("AIzaSyBZERafpFV42Sj2jt5dLkN6pVYrRTezWMU");

final ResultsControllerStateProvider =
    StateNotifierProvider<ResultsController, List<AutocompletePrediction>>(
        (ref) {
  return ResultsController([]);
});

class ResultsController extends StateNotifier<List<AutocompletePrediction>> {
  ResultsController(List<AutocompletePrediction> state) : super(state);

  Future<void> moveCameraToPlace(String value) async {
    final result = await _googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      state = result.predictions!;
    }
  }
}
