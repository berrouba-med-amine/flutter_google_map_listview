import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import "model/Restaurant.dart";

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  List<Restaurant> list = Restaurant.getRestaurants();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    // cereate restaurants markers
    for (Restaurant restaurant in list) {
      markers.add(Marker(
          markerId: MarkerId(restaurant.name),
          position: restaurant.location,
          infoWindow: InfoWindow(title: restaurant.name),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("G-Map Buttom Sheet list Demo"),
      ),
      body: Stack(
        children: <Widget>[
          _googleMap(context),
          _zoomControls(),
          _listContainer(),
        ],
      ),
    );
  }

  Widget _zoomControls() {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(FontAwesomeIcons.searchMinus, color: Colors.blue),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.zoomOut());
              }),
          IconButton(
              icon: Icon(FontAwesomeIcons.searchPlus, color: Colors.blue),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.zoomIn());
              }),
        ],
      ),
    );
  }

  Widget _listContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _fitedBox(list[index]);
          },
        ),
      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: list[0].location, zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(markers)),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  Widget _fitedBox(Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(
            restaurant.location.latitude, restaurant.location.longitude);
      },
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20),
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(restaurant.image),
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _detailRestaurant(restaurant),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _stars(int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var i = 0; i < number; i++)
          Container(
            child: Icon(
              FontAwesomeIcons.solidStar,
              color: Colors.amber,
              size: 15.0,
            ),
          ),
        SizedBox(
          width: 5,
        ),
        Container(
            child: Text(
          "(${number.toString()})",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }

  Widget _detailRestaurant(Restaurant restaurant) {
    return Column(
      children: <Widget>[
        Container(
            child: Text(
          restaurant.name,
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        )),
        SizedBox(height: 5.0),
        _stars(restaurant.stars),
        SizedBox(height: 5.0),
        Container(
          child: Text(restaurant.adress,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Open At ${restaurant.openAt}",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }
}
