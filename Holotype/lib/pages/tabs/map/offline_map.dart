import 'package:demo1/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

/**********************************************************************
*    Title: Flutter MapBox Integration: Complete Guide with Example
*    Author: Dhruv Nakum
*    Date: 2022
*    Availability: https://dhruvnakum.xyz/flutter-mapbox-integration-complete-guide-with-example
*
**********************************************************************/

class OfflineMap extends StatelessWidget {
  
  const OfflineMap({super.key});

  @override
  Widget build(BuildContext context) {

    Future<Position> position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) => value);

    // Let user know we need their location for offline map function.
    Fluttertoast.showToast(msg: "Warning: We need to record your location in order to provide offline map service!");

    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: const Text('Offline Map'),
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          actions: [
            ElevatedButton.icon(
              onPressed:() {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LogInPage();
                  }
                ));
              }, 
              icon: Icon(Icons.arrow_back), 
              label: Text("Return to Login"),              
            )
          ],
        ),

        body: Stack(
          children: [
            FutureBuilder(
              future: position,
              builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {

                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                }

                if (!snapshot.hasData) {
                  // Display loading icon when loading user location data.
                  // Under offline condition this may even take minutes, so we don't want user to keep in wait with no interface and signal.
                  return SpinKitFadingFour(color: Colors.green);
                } else {
                  // Display user's current location in an offline map of Australia, which can avoid user be in the middle of nowhere and met danger from the wild.
                  return FlutterMap(
                    options: MapOptions(
                      minZoom: 5,
                      maxZoom: 5,
                      zoom: 5,
                      center: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                      maxBounds: LatLngBounds(
                          LatLng(0.0, 101.25),
                          LatLng(-48.92249926375824, 168.75),
                      ),
                    ),
                    layers: [

                      TileLayerOptions(
                        tileProvider: AssetTileProvider(),
                        urlTemplate:
                          'assets/map/offline/{z}/{x}/{y}.png',
                      ),

                      MarkerLayerOptions(
                        markers: [
                          Marker(
                            height: 40,
                            width: 40,
                            point: LatLng(snapshot.data!.latitude, snapshot.data!.longitude), 
                            builder: (BuildContext context) {
                              return Image.asset('assets/icons8-location-96.png');
                            },
                            
                          ),
                        ]
                      )

                    ],
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
