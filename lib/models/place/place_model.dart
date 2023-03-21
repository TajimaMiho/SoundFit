import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
class PlaceModel with _$PlaceModel {
  @JsonSerializable(explicitToJson: true) // ここに一行追加
  const factory PlaceModel({
    required double lat,
    required double long,
  }) = _PlaceModel;

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}

/*Future<List<PlaceModel>> getPlaces() async {
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
}*/
