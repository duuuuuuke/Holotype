import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:demo1/pages/tabs/services/file_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'models/deco_user.dart';
import 'no_matches.dart';
import 'plant_details.dart';

class Camera001 extends StatefulWidget {
  const Camera001({Key? key}) : super(key: key);

  @override
  State<Camera001> createState() => _Camera001State();
}

class _Camera001State extends State<Camera001> {
  late DECOUser user;
  List resultList = [];
  late XFile image;

  //upload image and identification
  void imageIdentification(uid) async {
    FileServices fileServices = FileServices(uid: uid);
    var host =
        'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=yDM1Y6Hv0BGDYwfsm65RD7d7&client_secret=Klq1iEs4asGiSSjjSpOGM70IjkbQK0R8';
    image = await fileServices.getImageFilePath();
    var imageBytes = await image.readAsBytes();
    var imageBase64 = base64Encode(imageBytes);

    try {
      await Dio().get(host).then(
        (value) {
          // ignore: avoid_print
          print("get token done");
          String token = value.data["access_token"];
          var url =
              "https://aip.baidubce.com/rest/2.0/image-classify/v1/plant?access_token=$token";
          var params = {"image": imageBase64};

          // Use Baidu api to identify provided image file.
          Dio()
              .post(url,
                  data: params,
                  options:
                      Options(contentType: 'application/x-www-form-urlencoded'))
              .then(
            (value) async {
              List results = value.data["result"];
              int resultsNum = results.length;
              if (resultsNum < 2) {
                // ignore: avoid_print
                print("Find $resultsNum possible result");
              } else {
                // ignore: avoid_print
                print("Find $resultsNum possible results");
              }
              for (var result in results) {
                // ignore: avoid_print
                double score = result["score"];
                // ignore: avoid_print
                print(result);
                //translate the result
                String name = await translate(result["name"]).then(
                  (value) {
                    return value.toString();
                  },
                );
                // ignore: avoid_print
                print("Has $score confidence with $name.");
                if (name == "Non Plant") {
                  resultList.add("It's not a PLANT!!!");
                  break;
                } else if (score > 0.2) {
                  resultList.add("Has $score confidence with $name.");
                } else {}
              }
              ;
              if (resultList == []) {
                resultList.add("IT MAY BE A NEW PLANT!!!");
              }
            },
          );
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //translate
  translate(String text) async {
    // Set api parameters.
    String baseUrl = "http://api.fanyi.baidu.com/api/trans/vip/fieldtranslate?";
    Random random = Random.secure();
    int salt = random.nextInt(100000000);
    String sign = md5
        .convert(utf8.encode(
            "20221011001385514$text${salt}medicineV2M4a7NtuLCAhvhaRsIE"))
        .toString();

    // Get final api url.
    var url =
        "${baseUrl}q=$text&from=zh&to=en&appid=20221011001385514&salt=$salt&domain=medicine&sign=$sign";

    // Translate Chinese string to English string.
    String result = await Dio().get(url).then(
      (value) {
        return (value.data["trans_result"][0]["dst"]);
      },
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<DECOUser?>(context)!;
    imageIdentification(user.uid);

    //the button to show the result
    if (resultList != []) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.offline_pin_outlined),
          onPressed: () {
            File imagePass = File(image.path);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return PlantDetails(
                image: imagePass,
                result: resultList[0],
              );
            }));
          },
        ),
        //the content in body
        body: Center(
            child: Container(
                width: 300,
                height: 300,
                child: Text(
                  "Image recognition takes about 5 seconds, please don't click the button within this time. Please click the button to check the results after 5 seconds.",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ))),
      );
    } else {
      return SpinKitFadingFour(color: Colors.green);
    }
  }
}
