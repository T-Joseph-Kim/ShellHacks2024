import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];
  LatLng? _initialPosition;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR: " + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    getUserCurrentLocation().then((position) {
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _initialPosition!,
            infoWindow: InfoWindow(
              title: 'My Current Location',
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Director'),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: _initialPosition == null
            ? Center(
                child:
                    CircularProgressIndicator()) // Show loading spinner while fetching location
            : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition!,
                  zoom: 14.0,
                ),
                markers: Set<Marker>.of(_markers),
                myLocationEnabled: true,
                compassEnabled: true,
                mapType: MapType.normal,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print("Location: ${value.latitude}, ${value.longitude}");

            LatLng currentLatLng = LatLng(value.latitude, value.longitude);

            _markers.add(
              Marker(
                markerId: MarkerId("currentLocation"),
                position: currentLatLng,
                infoWindow: InfoWindow(
                  title: 'My Current Location',
                ),
              ),
            );

            CameraPosition cameraPosition = CameraPosition(
              target: currentLatLng,
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {});
          });
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
