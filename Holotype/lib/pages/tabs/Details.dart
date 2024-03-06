import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/pages/tabs/services/user_database_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'models/deco_user.dart';

class DetailPage extends StatefulWidget {
  final image;
  final description;
  final brief;
  final tags;
  final votes;
  final otherImages;
  final pid;
  DetailPage({
    super.key,
    required this.image,
    required this.description,
    required this.brief,
    required this.tags,
    required this.votes,
    required this.otherImages,
    required this.pid,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Img(
            votes: widget.votes,
            image: widget.image,
            pid: widget.pid,
          ),
          ImgGroup(
            otherImages: widget.otherImages,
          ),
          Description(
            brief: widget.brief,
            description: widget.description,
            tags: widget.tags,
          ),
          ThreeButtons(
            pid: widget.pid,
          )
        ],
      ),
    );
  }
}

// Full image with 4 widget in corners
class Img extends StatefulWidget {
  final votes;
  final image;
  final pid;
  Img({super.key, required this.votes, required this.image, required this.pid});

  @override
  State<Img> createState() => _ImgState();
}

class _ImgState extends State<Img> {
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
        .collection("post")
        .doc(widget.pid)
        .snapshots();
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.red),
              image: DecorationImage(
                  image: NetworkImage(widget.image), fit: BoxFit.fitWidth)),
        ),
        Positioned(
            top: 40,
            left: 30,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 183, 182, 182),
                  shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Color.fromARGB(255, 44, 94, 70),
                  )),
            )),
        Positioned(
            top: 40,
            right: 50,
            child: Icon(
              Icons.favorite,
              size: 40,
              color: Colors.orange,
            )),
        Positioned(
            top: 240,
            right: 50,
            child: Icon(
              Icons.thumb_up_rounded,
              size: 40,
              color: Colors.orange,
            )),
        Positioned(
          top: 252,
          right: 60,
          child: StreamBuilder(
              stream: _userStream,
              builder: ((BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                int currentVoting = snapshot.data?.get("voting");
                return Text(
                  currentVoting.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                );
              })),
        ),
      ],
    );
  }
}

// 1 * 2 small image
class ImgGroup extends StatefulWidget {
  final otherImages;
  ImgGroup({super.key, required this.otherImages});

  @override
  State<ImgGroup> createState() => _GroupState();
}

class _GroupState extends State<ImgGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 70,
              child: ClipRRect(
                child: SizedBox.fromSize(
                  child: widget.otherImages.length == 0
                      ? Container()
                      : Container(
                          child: Image(
                            image: NetworkImage(
                              widget.otherImages[0],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              )),
          Container(
              width: 70.0,
              child: ClipRRect(
                child: SizedBox.fromSize(
                  child: widget.otherImages.length != 2
                      ? Container()
                      : Container(
                          child: Image(
                            image: NetworkImage(
                              widget.otherImages[1],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              )),
        ],
      ),
    );
  }
}

// Description
class Description extends StatefulWidget {
  final description;
  final brief;
  final tags;
  Description({
    super.key,
    required this.brief,
    required this.description,
    required this.tags,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        width: 500,
        child: Column(children: [
          Container(
              child: Text(
                widget.brief,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Fatface", fontSize: 25),
              ),
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.red),
                  )),
          Container(
              child: Text(
                widget.description,
                style: TextStyle(
                    color: Color.fromRGBO(254, 255, 250, 0.6), fontSize: 15),
              ),
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.red),
                  )),
          Container(
              child: Text(
                widget.tags,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.red),
                  )),
        ]),
        height: 230,
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.red),
            color: Color.fromRGBO(44, 94, 70, 1)));
  }
}

// Buttons
class ThreeButtons extends StatefulWidget {
  final pid;
  const ThreeButtons({super.key, required this.pid});

  @override
  State<ThreeButtons> createState() => _ThreeButtonsState();
}

class _ThreeButtonsState extends State<ThreeButtons> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DECOUser?>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
            onPressed: () {
              // TODO: Route to COMMENT
              print("Test");
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 40),
              backgroundColor: Colors.orange,
            ),
            child: Text(
              "COMMENT",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        ElevatedButton(
            onPressed: () async {
              if (user != null) {
                bool isAdd = await UserDatabaseServices(user.uid)
                    .vote(widget.pid)
                    .then((value) => value);
                if (isAdd) {
                  Fluttertoast.showToast(msg: "Voting Success!");
                } else {
                  Fluttertoast.showToast(msg: "Voting Canceled!");
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 40),
              backgroundColor: Colors.orange,
            ),
            child: Text(
              "VOTE👍",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ]),
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
                // TODO: MAP Function
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

showDialogFunctionVote(context, pid) {
  final user = Provider.of<DECOUser?>(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Vote"),
        content: const Text("Are you sure you want to vote for this plant?"),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                if (user != null) {
                  UserDatabaseServices(user.uid).vote(pid);
                }
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
