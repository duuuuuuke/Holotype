import 'package:demo1/pages/Tabs.dart';
import 'package:demo1/pages/tabs/map/constant.dart';
import 'package:demo1/pages/tabs/map/marker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:latlong2/latlong.dart';

import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

class Map extends StatefulWidget {
  Map({super.key});

  Position? position;
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> with TickerProviderStateMixin {
  final Reference ref = FirebaseStorage.instance.ref();

  // Get post information stored in firestore database and return it when finished.
  Future<List<MapMarker>> getMarkers() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var posts =
        db.collection("post").orderBy("date", descending: true).limit(5);
    List<MapMarker> mapMarkers = await posts.get().then((value) async {
      List<MapMarker> mapMarkers = [];
      if (value.docs.isNotEmpty) {
        int count = 0;
        for (var element in value.docs) {
          print(count += 1);
          if (element.data()["display_location"] == true) {
            var imageRef = ref.child(element.data()['image_paths']['image_1']);

            var imageUrl = await imageRef.getDownloadURL().then(
              (value) {
                return value;
              },
            );

            print(imageUrl);

            mapMarkers.add(MapMarker(
                image: Image.network(imageUrl, fit: BoxFit.cover),
                title: element.data()["brief"],
                description: element.data()["description"],
                location: LatLng(element.data()["location"][0],
                    element.data()["location"][1])));
          }
        }
      } else {
        mapMarkers = [];
      }
      return mapMarkers;
    });
    print(mapMarkers);
    return mapMarkers;
  }

  final pageController = PageController();

  Position? _pos;

  void _getPosition() async {
    Position position = await _determinePosition();

    setState(() {
      _pos = position;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  int selectedIndex = 0;
  var currentLocation = AppConstants.myLocation;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  /**********************************************************************
  *    Title: Flutter MapBox Integration: Complete Guide with Example
  *    Author: Dhruv Nakum
  *    Date: 2022
  *    Availability: https://dhruvnakum.xyz/    flutter-mapbox-integration-complete-guide-with-example
  *
  **********************************************************************/

  // Center the map the the selected markers.
  void _mapMove(LatLng newLocation) {
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: newLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: newLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: 1);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<MapMarker>> mapMarkers = getMarkers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Map'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Tabs();
            }));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _getPosition();
          currentLocation = _pos == null
              ? currentLocation
              : LatLng(_pos!.latitude, _pos!.longitude);
          _mapMove(currentLocation);
          setState(() {});
        }),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          FutureBuilder<List<MapMarker>>(
            future: mapMarkers,
            builder: ((BuildContext context,
                AsyncSnapshot<List<MapMarker>> snapshot) {
              if (snapshot.hasData) {
                List<MapMarker>? mapMarkers = snapshot.data;

                return Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        minZoom: 5,
                        maxZoom: 15,
                        zoom: 15,
                        center: currentLocation,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://api.mapbox.com/styles/v1/dukebai/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                          additionalOptions: {
                            'mapStyleId': AppConstants.mapBoxStyleId,
                            'accessToken': AppConstants.mapBoxAccessToken,
                          },
                        ),
                        MarkerLayerOptions(
                          markers: [
                            for (int i = 0; i < mapMarkers!.length; i++)
                              Marker(
                                height: 40,
                                width: 40,
                                point: mapMarkers[i].location ??
                                    AppConstants.offlineTestLocation,
                                builder: (_) {
                                  return GestureDetector(
                                    onTap: () {
                                      pageController.animateToPage(
                                        i,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut,
                                      );
                                      selectedIndex = i;
                                      currentLocation =
                                          mapMarkers[i].location ??
                                              AppConstants.myLocation;
                                      _mapMove(currentLocation);
                                      setState(() {});
                                    },
                                    child: AnimatedScale(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      scale: selectedIndex == i ? 1 : 0.7,
                                      child: AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        opacity: selectedIndex == i ? 1 : 0.5,
                                        child: Image.asset(
                                          'assets/icons8-location-96.png',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 2,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: PageView.builder(
                        controller: pageController,
                        onPageChanged: (value) {
                          selectedIndex = value;
                          currentLocation = mapMarkers[value].location ??
                              AppConstants.myLocation;
                          _mapMove(currentLocation);
                          setState(() {});
                        },
                        itemCount: mapMarkers.length,
                        itemBuilder: (_, index) {
                          final item = mapMarkers[index];
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: const Color.fromARGB(255, 29, 30, 29),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return const Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                    255, 29, 30, 29),
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.title ?? '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.lightGreen),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                item.description ?? '',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: item.image,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return SpinKitDualRing(color: Colors.green);
              }
            }),
          ),
        ],
      ),
    );
  }
}
