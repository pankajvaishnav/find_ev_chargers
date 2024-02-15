import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/locations_model.dart';
import '../widgets/custom_app_bar.dart';

class MapScreen extends StatefulWidget {
  final LocationResponse locationResponse;
  final double lat, lng;
  const MapScreen({super.key, required this.locationResponse, required this.lat, required this.lng});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

      Set<Marker> markers = {};
      BitmapDescriptor? icon;



  void _addMarker(obj) {
    Location location = obj;
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId('${location.locationData.coordinates.latitude}${location.locationData.coordinates.latitude}'),
          position: LatLng(location.locationData.coordinates.latitude == null ? 37.7749 :
            double.parse(location.locationData.coordinates.latitude),  //37.7749
              location.locationData.coordinates.latitude == null ? -122.4194 : 
              double.parse(location.locationData.coordinates.longitude)), // Coordinates of the marker
          infoWindow: InfoWindow(
            title: location.locationData.entityCode,
            snippet: //"Charger ID: ${location.locationData.entityCode}"
            "Brand: ${location.locationData.name}",
          ),
          icon: icon!,
        ),
      );
    });
  }

  Future getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3.2,
        size: Size(64, 64)),
        "assets/images/charging-station.png",);
    setState(() {
      this.icon = icon;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(widget.lat, widget.lng),
        zoom: 14.4746,
      );
    });
    getIcons().then((value){
      for(final obj in widget.locationResponse.locations){
      _addMarker(obj);
    }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(68), 
              child: CustomAppbar(title: "Nearby Chargers", 
        showLeading: true),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomControlsEnabled: false,
        markers: markers,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}