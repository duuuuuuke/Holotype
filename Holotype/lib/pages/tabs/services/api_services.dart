import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demo1/pages/tabs/services/file_service.dart';

class ApiServices {

  late String uid;

  ApiServices({required this.uid}) {
    uid = uid;
  }

  // Image identification function implemented by using Baidu's plant identification api.
  // https://ai.baidu.com/ai-doc/IMAGERECOGNITION/Mk3bcxe9i
  imageIdentification() async {

    List resultList = [];
    // Set api parameters.
    FileServices fileServices = FileServices(uid: uid);
    var host =
        'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=yDM1Y6Hv0BGDYwfsm65RD7d7&client_secret=Klq1iEs4asGiSSjjSpOGM70IjkbQK0R8';
    XFile image = await fileServices.getImageFilePath();
    var imageBytes = await image.readAsBytes();
    var imageBase64 = base64Encode(imageBytes);

    try {
      await Dio().get(host).then(
        (value) {

          String token = value.data["access_token"];
          var url =
              "https://aip.baidubce.com/rest/2.0/image-classify/v1/plant?access_token=$token";
          var params = {"image": imageBase64};

          // Use Baidu api to identify provided image file.
          Dio().post(url, data: params, options: Options(contentType: 'application/x-www-form-urlencoded')).then(
            (value) async {

              List results = value.data["result"];

              for (var result in results) {

                double score = result["score"];
                var name = await translate(result["name"]).then(
                  (value) {
                    return value;
                  },
                );

                // Filter some result with low confidence or not a plant at all.
                if (name == "非植物") {
                  resultList.add("It's not a PLANT!!!");
                } else if (score > 0.2) {
                  resultList.add("Has $score confidence with $name.");
                }
              }

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
    return resultList;
  }

  // Use Baidu translation api to transfer Chinese string into English.
  // https://api.fanyi.baidu.com/product/12
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

    // Transalte Chinese string to English string.
    String result = await Dio().get(url).then(
      (value) {
        return (value.data["trans_result"][0]["dst"]);
      },
    );

    return result;
  }
}
