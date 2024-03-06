import 'dart:io';
import 'dart:math';

import 'package:demo1/pages/Tabs.dart';
import 'package:demo1/pages/tabs/screens/authenticate/authenticate.dart';
import 'package:demo1/pages/tabs/services/auth_services.dart';
import 'package:demo1/pages/tabs/services/user_database_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'models/deco_user.dart';

class JournalLog extends StatefulWidget {
  const JournalLog({Key? key}) : super(key: key);

  @override
  State<JournalLog> createState() => _JournalLogState();
}

class _JournalLogState extends State<JournalLog> {
  final AuthServices _auth = AuthServices();

  File? _imageOne;
  File? _imageTwo;
  File? _imageThree;
  final imagePicker = ImagePicker();
  String brief = "";
  List feature = [];
  String description = "";
  List<double> location = [];
  String feature1 = "";
  String feature2 = "";
  String feature3 = "";
  String feature4 = "";
  String feature5 = "";
  double lat = 0;
  double lon = 0;
  String latString = "";
  String lonString = "";
  String locationStr = "";

  //get location
  void getGeolocation() async {
    Position position = await Geolocator.getCurrentPosition();
    Random random = Random.secure();
    lat = position.latitude + random.nextDouble() * 0.01;
    lon = position.longitude + random.nextDouble() * 0.01;
    location.add(lat);
    location.add(lon);
    latString = lat.toString();
    lonString = lon.toString();
    locationStr = latString + ", " + lonString;
  }

  //get image
  Future getImage() async {
    if (_imageOne == null) {
      final imageOne = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageOne = File(imageOne!.path);
      });
    } else if (_imageTwo == null) {
      final imageTwo = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageTwo = File(imageTwo!.path);
      });
    } else if (_imageThree == null) {
      final imageThree =
          await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageThree = File(imageThree!.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getGeolocation();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DECOUser?>(context);

    if (user != null) {
      UserDatabaseServices userDatabaseService = UserDatabaseServices(user.uid);
      print(locationStr);

      return Scaffold(
        appBar: AppBar(
            //back to page
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            //refresh and go to home page
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return JournalLog();
                    }));
                  },
                  icon: const Icon(Icons.refresh)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const MyApp();
                    }));
                  },
                  icon: const Icon(Icons.home))
            ]),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "JOURNAL LOG",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //brief information
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() => brief = val);
                          },
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: "Brief Information",
                              hintStyle: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                      ),
                      //location
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: locationStr,
                              hintStyle: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //three images
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 110,
                            height: 110,
                            child: Container(
                              color: Colors.white54,
                              child: _imageOne == null
                                  ? Container()
                                  : Image.file(
                                      _imageOne!,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            height: 110,
                            child: Container(
                              color: Colors.white54,
                              child: _imageTwo == null
                                  ? Container()
                                  : Image.file(
                                      _imageTwo!,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            height: 110,
                            child: Container(
                              color: Colors.white54,
                              child: _imageThree == null
                                  ? Container()
                                  : Image.file(
                                      _imageThree!,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Notable Features:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //five features
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() => feature1 = val);
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: "Feature1",
                                  hintStyle: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() => feature2 = val);
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: "Feature2",
                                  hintStyle: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() => feature3 = val);
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: "Feature3",
                                  hintStyle: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() => feature4 = val);
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: "Feature4",
                                  hintStyle: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() => feature5 = val);
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: "Feature5",
                                  hintStyle: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //description
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() => description = val);
                          },
                          autofocus: false,
                          maxLines: 10,
                          decoration: InputDecoration(
                              hintText:
                                  "Description: Hint: Please upload at least one image, otherwise please go back to HomePage.",
                              hintStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              //upload data
              Container(
                  width: 300,
                  height: 60,
                  color: Colors.orange,
                  child: TextButton(
                    onPressed: (() async {
                      if (_imageOne == null) {
                        Fluttertoast.showToast(
                            msg: "Please upload at least one photo!");
                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const Tabs();
                        }));
                        List files = [];
                        files.add(_imageOne);
                        files.add(_imageTwo);
                        files.add(_imageThree);
                        feature.add(feature1);
                        feature.add(feature2);
                        feature.add(feature3);
                        feature.add(feature4);
                        feature.add(feature5);
                        await userDatabaseService.savePost(
                            files, brief, feature, description, location);
                        _imageOne = null;
                        _imageTwo = null;
                        _imageThree = null;
                      }
                    }),
                    child: const Text(
                      "Share",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
        //upload image and show it on this page
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_a_photo),
          onPressed: getImage,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    } else {
      return const Authenticate();
    }
  }
}
