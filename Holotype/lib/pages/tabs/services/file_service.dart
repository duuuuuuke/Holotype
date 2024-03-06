import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

/**********************************************************************
*    Title: Cloud Storage for Firebase Documentation
*    Author: Google Firebase
*    Date: 2022
*    Availability: https://firebase.google.com/docs/storage
*
**********************************************************************/

class FileServices {

  late String uid;
  final Reference ref = FirebaseStorage.instance.ref();

  FileServices({required this.uid}) {
    uid = uid;
  }

  // Upload file(image) to Google firebase storage.
  uploadFiles(File file, String pid, String imageFileName) async {    

    // Generate path to store this image.
    final path = '/$uid/$pid/$imageFileName.jpg';
    var userRef = ref.child(path);

    // Upload images.
    userRef.putFile(file);
  }

  // Get image files from device album.
  getImageFiles() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final image = File(pickedFile!.path);
    return image;
  }

  // Get image paths from device album.
  getImageFilePath() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  // Upload a cached file.
  uploadCachedFile(File file) async {
    final path = '$uid/postID/image.jpg';
    var userRef = ref.child(path);
    userRef.putFile(file);
  }

  // Get and generate an Image widget from an url.
  Future<Image> getImageByUrl(String url) async {

    var imageRef = ref.child(url);

    final imageUrl = await imageRef.getDownloadURL().then((value) {
      return value;
    },);

    return Image.network(imageUrl);
  }

}