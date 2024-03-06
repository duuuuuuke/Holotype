import 'dart:io';

import 'package:flutter/material.dart';
import '../../main.dart';
import 'Journal_log.dart';

class PlantDetails extends StatefulWidget {
  final String result;
  final File image;
  PlantDetails({super.key, required this.image, required this.result});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //back button
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          //refresh and back to home page
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return PlantDetails(
                      image: widget.image,
                      result: widget.result,
                    );
                  }));
                },
                icon: const Icon(Icons.refresh)),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const MyApp();
                  }));
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              // the uploaded iamge
              Container(
                width: 300,
                height: 300,
                child: Image.file(
                  widget.image,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Match Found",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.result,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              // go to the page where we can post log
              Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 60,
                  color: Colors.orange,
                  child: TextButton(
                    onPressed: () {
                      showDialogFunctionLocation(context);
                    },
                    child: const Text(
                      "Journal Log",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  )),
            ],
          ),
        ));
  }
}

//confirm the permission to use the users' locations
showDialogFunctionLocation(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm permission"),
        content: const Text(
            "Do you agree that we will automatically obtain your current location? It will take few seconds to get the location information. Please wait for few seconds before doing any operations. Tips: DO NOT UPLOAD EMPTY IMAGE!"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return JournalLog();
                }));
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
