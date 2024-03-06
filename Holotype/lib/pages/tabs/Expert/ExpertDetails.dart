import 'package:flutter/material.dart';

class ExpertDetailPage extends StatefulWidget {
  final image;
  final description;
  final brief;
  final tags;
  final votes;
  final otherImages;
  ExpertDetailPage({
    super.key,
    required this.image,
    required this.description,
    required this.brief,
    required this.tags,
    required this.votes,
    required this.otherImages,
  });

  @override
  State<ExpertDetailPage> createState() => _ExpertDetailPageState();
}

class _ExpertDetailPageState extends State<ExpertDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Img(
            votes: widget.votes,
            image: widget.image,
          ),
          ImgGroup(
            otherImages: widget.otherImages,
          ),
          Description(
            brief: widget.brief,
            description: widget.description,
            tags: widget.tags,
          ),
          ThreeButtons()
        ],
      ),
    );
  }
}

// Full image with 4 widget in corners
class Img extends StatefulWidget {
  final votes;
  final image;
  Img({super.key, required this.votes, required this.image});

  @override
  State<Img> createState() => _ImgState();
}

class _ImgState extends State<Img> {
  @override
  Widget build(BuildContext context) {
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
            child: Text(
              widget.votes,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
        Positioned(
            top: 220,
            left: 30,
            child: Container(
              width: 300,
              height: 80,
              // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      child: Text(
                        "Fine Leaf Green Grass",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Fatface"),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Agnes Don",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "G2HF+3M Brisbane City, Queensland",
                      style:
                          TextStyle(color: Colors.white, fontFamily: "Fatface"),
                    )
                  ],
                )
              ]),
            ))
      ],
    );
  }
}

// 1 * 4 small image
class ImgGroup extends StatefulWidget {
  final otherImages;
  ImgGroup({super.key, required this.otherImages});

  @override
  State<ImgGroup> createState() => _ImgGroupState();
}

class _ImgGroupState extends State<ImgGroup> {
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
                          child: Ink.image(
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
                          child: Ink.image(
                            image: NetworkImage(
                              widget.otherImages[1],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              )),
          Container(
              width: 70,
              child: ClipRRect(
                child: SizedBox.fromSize(
                  child: Image.asset("assets/img/Part3.png", fit: BoxFit.cover),
                ),
              )),
          Container(
              width: 70,
              child: ClipRRect(
                child: SizedBox.fromSize(
                  child: Image.asset("assets/img/Part4.png", fit: BoxFit.cover),
                ),
              ))
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
class ThreeButtons extends StatelessWidget {
  const ThreeButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              primary: Colors.orange,
            ),
            child: Text(
              "COMMENT",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        ElevatedButton(
            onPressed: () {
              showDialogFunctionVote(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 40),
              backgroundColor: Colors.orange,
            ),
            child: Text(
              "Mark As New Species",
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

showDialogFunctionVote(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Mark"),
        content:
            const Text("Are you sure to mark this plant as a new species?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
