import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/models/place/place_model.dart';
import 'package:mycloud/provider/markers/markers_provider.dart';
import 'package:mycloud/provider/place_model/place_model_provider.dart';
import 'package:mycloud/service/will_pop_call_back.dart';

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mycloud/view/top/add/place_list_page/place_list_page.dart';
import 'package:provider/provider.dart';

class TopPage extends ConsumerWidget {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<Position>(
        future: Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final position = snapshot.data!;
            final initialPosition =
                LatLng(position.latitude, position.longitude);
            ref.watch(placeModelProvider.notifier).getPlaces();
            final places = ref.watch(placeModelProvider);
            if (places == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            ref.watch(markersProvider.notifier).addMarkers(places);
            return SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: initialPosition,
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) async {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapToolbarEnabled: false,
                    buildingsEnabled: true,
                    onTap: (LatLng latLng) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopListPage(
                            lat: latLng.latitude,
                            long: latLng.longitude,
                            shoptitle: 'どこか',
                          ),
                        ),
                      );
                      print(latLng);
                    },
                    markers: Set.from(ref.watch(markersProvider)),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


/*class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Completer<GoogleMapController> _controller = Completer();

  late LatLng _initialPosition;
  late bool _loading;

  void initState() {
    super.initState();
    _loading = true;
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _loading = false;
      print(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //前のページに戻らせたくない時に使う
      onWillPop: willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Consumer(
                      builder: (context, watch, child) {
                        final markers = watch(markersProvider);
                        return GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _initialPosition,
                            zoom: 14.4746,
                          ),
                          onMapCreated: (GoogleMapController controller) async {
                            _controller.complete(controller);
                            final places = await getPlaces();
                            context.read(markersProvider).addMarkers(places);
                          },
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          mapToolbarEnabled: false,
                          buildingsEnabled: true,
                          onTap: (LatLng latLng) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopListPage(
                                        lat: latLng.latitude,
                                        long: latLng.longitude,
                                        shoptitle: 'どこか',
                                      )),
                            );
                            print(latLng);
                          },
                          markers: Set.from(markers),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}*/


/*class _TopPageState extends State<TopPage> {
  Completer<GoogleMapController> _controller = Completer();

  late LatLng _initialPosition;
  late bool _loading;

  void initState() {
    super.initState();
    _loading = true;
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _loading = false;
      print(position);
    });
  }

  void _addMarkers(List<PlaceModel> places, GoogleMapController controller) {
    places.forEach((place) {
      final marker = Marker(
        markerId: MarkerId('${place.lat}-${place.long}'),
        position: LatLng(place.lat, place.long),
        infoWindow: InfoWindow(title: 'Place'),
      );
      controller.addMarker(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //前のページに戻らせたくない時に使う
      onWillPop: willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: 14.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) async {
                        _controller.complete(controller);
                        final places = await getPlaces();
                        _addMarkers(places, controller);
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapToolbarEnabled: false,
                      buildingsEnabled: true,
                      onTap: (LatLng latLng) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShopListPage(
                                    lat: latLng.latitude,
                                    long: latLng.longitude,
                                    shoptitle: 'どこか',
                                  )),
                        );
                        print(latLng);
                      },
                    ),
                    //buildFloatingSearchBar(),
                  ],
                ),
              ),
      ),
    );
  }
}*/