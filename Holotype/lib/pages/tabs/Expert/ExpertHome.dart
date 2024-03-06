import 'package:flutter/material.dart';
import 'package:demo1/pages/Tabs.dart';
import 'package:demo1/pages/tabs/map/map.dart';
import 'ExpertDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExpertHomePage extends StatefulWidget {
  const ExpertHomePage({Key? key}) : super(key: key);

  @override
  State<ExpertHomePage> createState() => _ExpertHomePageState();
}

class _ExpertHomePageState extends State<ExpertHomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(children: [
            Top(),
            Text1(),
            Text2(),
            Block1(),
          ]),
        )
      ],
    );
  }
}

// Message, Search and UserProfile
class Top extends StatelessWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          // Message
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              showDialogFunctionMap(context);
            },
            icon: Icon(
              Icons.pin_drop_outlined,
              color: Color.fromARGB(255, 44, 94, 70),
            ),
            iconSize: 30,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Row(children: [
            Container(
              // Search
              height: 30,
              margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: Icon(
                Icons.search,
                color: Color.fromARGB(255, 44, 94, 70),
                size: 30,
              ),
            ),
            Container(
              // User Image
              child: IconButton(
                icon: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/img.png"),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle)),
                onPressed: () {
                  // TODO: BUG
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Tabs();
                    },
                  ));
                },
              ),
            )
          ]),
        ),
      ]),
    );
  }
}

// Text1
class Text1 extends StatelessWidget {
  const Text1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 20, 0),
      child: Text(
        "Today",
        style: TextStyle(
            fontFamily: "Fatface",
            color: Color.fromARGB(255, 44, 94, 70),
            fontSize: 30),
      ),
    );
  }
}

// Text2
class Text2 extends StatelessWidget {
  const Text2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 20, 0),
      child: Text(
        "New & Popular Story",
        style: TextStyle(
            fontFamily: "Fatface",
            color: Color.fromARGB(255, 44, 94, 70),
            fontSize: 30),
      ),
    );
  }
}

// Block1
class Block1 extends StatefulWidget {
  const Block1({Key? key}) : super(key: key);

  @override
  State<Block1> createState() => _Block1State();
}

class _Block1State extends State<Block1> {
  final Reference ref = FirebaseStorage.instance.ref();
  List imageList = [];
  List otherImageList = [];
  List briefList = [];
  List tagList = [];
  List voteList = [];
  List descriptionList = [];

  void getInfo() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var posts =
        db.collection("post").orderBy("voting", descending: true).limit(3);
    posts.get().then((value) async {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          var otherImages = [];
          if (element.data()['image_paths']['image_1'] != null) {
            var imageRef = ref.child(element.data()['image_paths']['image_1']);
            var imageUrl = await imageRef.getDownloadURL().then(
              (value) {
                return value;
              },
            );
            if (element.data()['image_paths']['image_2'] != null) {
              var imageRef2 =
                  ref.child(element.data()['image_paths']['image_2']);
              var imageUrl2 = await imageRef2.getDownloadURL().then(
                (value) {
                  return value;
                },
              );
              otherImages.add(imageUrl2);
              if (element.data()['image_paths']['image_3'] != null) {
                var imageRef3 =
                    ref.child(element.data()['image_paths']['image_3']);
                var imageUrl3 = await imageRef3.getDownloadURL().then(
                  (value) {
                    return value;
                  },
                );
                otherImages.add(imageUrl3);
              }
            }
            setState(() {
              imageList.add(imageUrl);
              otherImageList.add(otherImages);
              briefList.add(element.data()["brief"]);
              descriptionList.add(element.data()["description"]);
              String allTag = "";
              for (var tagInfo in element.data()["feature_tag"]) {
                if (tagInfo != null) {
                  allTag += tagInfo;
                  allTag += ",";
                  tagList.add(allTag);
                  allTag = "";
                }
              }
              voteList.add(element.data()["voting"].toString());
            });
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (imageList.length == 3) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: Center(
          child: Column(
            children: [
              Container(
                // BackGround
                width: 350,
                height: 350,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(44, 94, 70, 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Stack(
                  children: [
                    Positioned(
                      // Img
                      top: 10,
                      left: 35,
                      child: InkWell(
                        onTap: () {
                          // TODO: To Details Page
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ExpertDetailPage(
                                image: imageList[0],
                                description: descriptionList[0],
                                brief: briefList[0],
                                tags: tagList[0],
                                votes: voteList[0],
                                otherImages: otherImageList[0],
                              );
                            },
                          ));
                        },
                        child: Ink.image(
                            image: NetworkImage(
                              imageList[0],
                            ),
                            width: 280.0,
                            height: 180.0,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                        // Text "New"
                        top: 210,
                        left: 35,
                        child: Text(
                          "New",
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                        )),
                    Positioned(
                        // Text "BRIEF INFORMATION"
                        top: 235,
                        left: 35,
                        child: Text(
                          briefList[0],
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontFamily: "Broadway"),
                        )),
                    Positioned(
                        // Text "Dark green, broad leaves with veins"
                        top: 260,
                        left: 35,
                        child: Text(
                          tagList[0],
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                        )),
                    Positioned(
                        // Text "Report"
                        top: 310,
                        left: 35,
                        child: Text(
                          "Report",
                          style: TextStyle(
                              color: Color.fromRGBO(44, 94, 70, 1),
                              fontSize: 12),
                        )),
                    Positioned(
                      // Row with 3 icons
                      top: 295,
                      left: 180,
                      child: Container(
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: Colors.orange,
                                size: 30,
                              ),
                              Icon(
                                Icons.text_snippet,
                                color: Colors.orange,
                                size: 30,
                              ),
                              Icon(
                                Icons.location_pin,
                                color: Colors.orange,
                                size: 30,
                              )
                            ],
                          )),
                    ),
                    Positioned(
                      top: 308,
                      left: 203,
                      child: Text(
                        voteList[0],
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                // BackGround
                width: 350,
                height: 350,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(44, 94, 70, 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Stack(
                  children: [
                    Positioned(
                      // Img
                      top: 10,
                      left: 35,
                      child: InkWell(
                        onTap: () {
                          // TODO: To Details Page
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ExpertDetailPage(
                                image: imageList[1],
                                description: descriptionList[1],
                                brief: briefList[1],
                                tags: tagList[1],
                                votes: voteList[1],
                                otherImages: otherImageList[1],
                              );
                            },
                          ));
                        },
                        child: Ink.image(
                            image: NetworkImage(
                              imageList[1],
                            ),
                            width: 280.0,
                            height: 180.0,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                        // Text "New"
                        top: 210,
                        left: 35,
                        child: Text(
                          "New",
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                        )),
                    Positioned(
                        // Text "BRIEF INFORMATION"
                        top: 235,
                        left: 35,
                        child: Text(
                          briefList[1],
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontFamily: "Broadway"),
                        )),
                    Positioned(
                        // Text "Dark green, broad leaves with veins"
                        top: 260,
                        left: 35,
                        child: Text(
                          tagList[1],
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                        )),
                    Positioned(
                        // Text "Report"
                        top: 310,
                        left: 35,
                        child: Text(
                          "Report",
                          style: TextStyle(
                              color: Color.fromRGBO(44, 94, 70, 1),
                              fontSize: 12),
                        )),
                    Positioned(
                      // Row with 3 icons
                      top: 295,
                      left: 180,
                      child: Container(
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: Colors.orange,
                                size: 30,
                              ),
                              Icon(
                                Icons.text_snippet,
                                color: Colors.orange,
                                size: 30,
                              ),
                              Icon(
                                Icons.location_pin,
                                color: Colors.orange,
                                size: 30,
                              )
                            ],
                          )),
                    ),
                    Positioned(
                      top: 308,
                      left: 203,
                      child: Text(
                        voteList[1],
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                // BackGround
                width: 350,
                height: 350,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(44, 94, 70, 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Stack(
                  children: [
                    Positioned(
                      // Img
                      top: 10,
                      left: 35,
                      child: InkWell(
                        onTap: () {
                          // TODO: To Details Page
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ExpertDetailPage(
                                image: imageList[2],
                                description: descriptionList[2],
                                brief: briefList[2],
                                tags: tagList[2],
                                votes: voteList[2],
                                otherImages: otherImageList[2],
                              );
                            },
                          ));
                        },
                        child: Ink.image(
                            image: NetworkImage(
                              imageList[2],
                            ),
                            width: 280.0,
                            height: 180.0,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                        // Text "New"
                        top: 210,
                        left: 35,
                        child: Text(
                          "New",
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                        )),
                    Positioned(
                        // Text "BRIEF INFORMATION"
                        top: 235,
                        left: 35,
                        child: Text(
                          briefList[2],
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontFamily: "Broadway"),
                        )),
                    Positioned(
                        // Text "Dark green, broad leaves with veins"
                        top: 260,
                        left: 35,
                        child: Text(
                          tagList[2],
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                        )),
                    Positioned(
                        // Text "Report"
                        top: 310,
                        left: 35,
                        child: Text(
                          "Report",
                          style: TextStyle(
                              color: Color.fromRGBO(44, 94, 70, 1),
                              fontSize: 12),
                        )),
                    Positioned(
                      // Row with 3 icons
                      top: 295,
                      left: 180,
                      child: Container(
                          width: 150,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: Colors.orange,
                                size: 30,
                              ),
                              Icon(
                                Icons.text_snippet,
                                color: Colors.orange,
                                size: 30,
                              ),
                              Icon(
                                Icons.location_pin,
                                color: Colors.orange,
                                size: 30,
                              )
                            ],
                          )),
                    ),
                    Positioned(
                      top: 308,
                      left: 203,
                      child: Text(
                        voteList[2],
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SpinKitFadingFour(color: Colors.green);
    }
  }
}

// Block2
class Block2 extends StatelessWidget {
  const Block2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      height: 350,
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Center(
          child: Container(
        // BackGround
        width: 350,
        height: 350,
        decoration: BoxDecoration(
            color: Color.fromRGBO(44, 94, 70, 0.1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(children: [
          Positioned(
              // Img
              top: 10,
              left: 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Image border
                child: SizedBox.fromSize(
                  child: Image.asset("assets/img/Plant3.jpg",
                      width: 280.0, height: 180.0, fit: BoxFit.cover),
                ),
              )),
          Positioned(
              // Text "New"
              top: 210,
              left: 35,
              child: Text(
                "New",
                style: TextStyle(color: Colors.orange, fontSize: 12),
              )),
          Positioned(
              // Text "BRIEF INFORMATION"
              top: 235,
              left: 35,
              child: Text(
                "BRIEF INFORMATION",
                style: TextStyle(
                    color: Colors.orange, fontSize: 20, fontFamily: "Broadway"),
              )),
          Positioned(
              // Text "Dark green, broad leaves with veins"
              top: 260,
              left: 35,
              child: Text(
                "Dark green, broad leaves with veins",
                style: TextStyle(color: Colors.orange, fontSize: 12),
              )),
          Positioned(
              // Text "Report"
              top: 310,
              left: 35,
              child: Text(
                "Report",
                style: TextStyle(
                    color: Color.fromRGBO(44, 94, 70, 1), fontSize: 12),
              )),
          Positioned(
            // Row with 3 icons
            top: 295,
            left: 180,
            child: Container(
                width: 150,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Colors.orange,
                      size: 30,
                    ),
                    Icon(
                      Icons.text_snippet,
                      color: Colors.orange,
                      size: 30,
                    ),
                    Icon(
                      Icons.location_pin,
                      color: Colors.orange,
                      size: 30,
                    )
                  ],
                )),
          ),
          Positioned(
              top: 308,
              left: 203,
              child: Text(
                "8",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ))
        ]),
      )),
    );
  }
}

// Block3
class Block3 extends StatelessWidget {
  const Block3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      height: 350,
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Center(
          child: Container(
        // BackGround
        width: 350,
        height: 350,
        decoration: BoxDecoration(
            color: Color.fromRGBO(44, 94, 70, 0.1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(children: [
          Positioned(
              // Img
              top: 10,
              left: 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Image border
                child: SizedBox.fromSize(
                  child: Image.asset("assets/img/Plant1.jpg",
                      width: 280.0, height: 180.0, fit: BoxFit.cover),
                ),
              )),
          Positioned(
              // Text "New"
              top: 210,
              left: 35,
              child: Text(
                "New",
                style: TextStyle(color: Colors.orange, fontSize: 12),
              )),
          Positioned(
              // Text "BRIEF INFORMATION"
              top: 235,
              left: 35,
              child: Text(
                "BRIEF INFORMATION",
                style: TextStyle(
                    color: Colors.orange, fontSize: 20, fontFamily: "Broadway"),
              )),
          Positioned(
              // Text "Dark green, broad leaves with veins"
              top: 260,
              left: 35,
              child: Text(
                "Dark green, broad leaves with veins",
                style: TextStyle(color: Colors.orange, fontSize: 12),
              )),
          Positioned(
              // Text "Report"
              top: 310,
              left: 35,
              child: Text(
                "Report",
                style: TextStyle(
                    color: Color.fromRGBO(44, 94, 70, 1), fontSize: 12),
              )),
          Positioned(
            // Row with 3 icons
            top: 295,
            left: 180,
            child: Container(
                width: 150,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Colors.orange,
                      size: 30,
                    ),
                    Icon(
                      Icons.text_snippet,
                      color: Colors.orange,
                      size: 30,
                    ),
                    Icon(
                      Icons.location_pin,
                      color: Colors.orange,
                      size: 30,
                    )
                  ],
                )),
          ),
          Positioned(
              top: 308,
              left: 203,
              child: Text(
                "5",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ))
        ]),
      )),
    );
  }
}

/// showDialog
showDialogFunctionMap(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Notification"),
        content: const Text(
            "Are you willing to authorize the location service function of the phone?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Map()),
                );
              },
              child: const Text("Yes")),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"),
          ),
        ],
      );
    },
  );
}
