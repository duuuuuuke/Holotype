import 'package:demo1/pages/setting_page.dart';
import 'package:demo1/pages/tabs/models/deco_user.dart';
import 'package:demo1/pages/tabs/services/user_database_services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DECOUser?>(context)!;
    UserDatabaseServices userDatabaseServices = UserDatabaseServices(user.uid);
    Future<List<Image>> images =
        userDatabaseServices.getImagesByUser().then((value) => value);

    return Container(
      child: ListView(
        children: [
          Stack(
            children: [
              // White Background.
              Container(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                color: Colors.white,
              )),

              Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Center(
                    child: Column(children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/img/img.png"),
                              fit: BoxFit.contain,
                            ),
                            shape: BoxShape.circle),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          "Agnes Don",
                          style: TextStyle(
                              color: Color.fromARGB(255, 44, 94, 70),
                              fontFamily: "Fatface",
                              fontSize: 50),
                        ),
                      ),

                      // Container of six images.
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          // One column of two rows of images, each row has three images.
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),

                              // One row of three images.
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Use FutureBuilder to build image widgets after corresponding data is received.
                                  FutureBuilder(
                                    future: images,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Image>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Text("error!");
                                        }
                                      }

                                      if (!snapshot.hasData) {
                                        return SpinKitFadingFour(
                                            color: Colors.green);
                                      } else if (snapshot.data!.length > 0) {
                                        return Container(
                                            width: 100.0,
                                            height: 100.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox.fromSize(
                                                child: snapshot.data![0],
                                              ),
                                            ));
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),

                                  FutureBuilder(
                                    future: images,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Image>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Text("error!");
                                        }
                                      }

                                      if (!snapshot.hasData) {
                                        return SpinKitFadingFour(
                                            color: Colors.green);
                                      } else if (snapshot.data!.length > 1) {
                                        return Container(
                                            width: 100.0,
                                            height: 100.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox.fromSize(
                                                child: snapshot.data![1],
                                              ),
                                            ));
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),

                                  FutureBuilder(
                                    future: images,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Image>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Text("error!");
                                        }
                                      }

                                      if (!snapshot.hasData) {
                                        return SpinKitFadingFour(
                                            color: Colors.green);
                                      } else if (snapshot.data!.length > 2) {
                                        return Container(
                                            width: 100.0,
                                            height: 100.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox.fromSize(
                                                child: snapshot.data![2],
                                              ),
                                            ));
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FutureBuilder(
                                    future: images,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Image>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Text("error!");
                                        }
                                      }

                                      if (!snapshot.hasData) {
                                        return SpinKitFadingFour(
                                            color: Colors.green);
                                      } else if (snapshot.data!.length > 3) {
                                        return Container(
                                            width: 100.0,
                                            height: 100.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox.fromSize(
                                                child: snapshot.data![3],
                                              ),
                                            ));
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  FutureBuilder(
                                    future: images,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Image>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Text("error!");
                                        }
                                      }

                                      if (!snapshot.hasData) {
                                        return SpinKitFadingFour(
                                            color: Colors.green);
                                      } else if (snapshot.data!.length > 4) {
                                        return Container(
                                            width: 100.0,
                                            height: 100.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox.fromSize(
                                                child: snapshot.data![4],
                                              ),
                                            ));
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  FutureBuilder(
                                    future: images,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Image>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Text("error!");
                                        }
                                      }

                                      if (!snapshot.hasData) {
                                        return SpinKitFadingFour(
                                            color: Colors.green);
                                      } else if (snapshot.data!.length > 5) {
                                        return Container(
                                            width: 100.0,
                                            height: 100.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox.fromSize(
                                                child: snapshot.data![5],
                                              ),
                                            ));
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ]))
                    ]),
                  )),

              Positioned(
                // Icon Settings.
                top: 230,
                right: 30,
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      size: 30,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SettingPage();
                      }));
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
