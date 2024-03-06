import 'file_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:demo1/pages/tabs/models/deco_user.dart';
import 'package:demo1/pages/tabs/models/user_information.dart';

import 'package:geolocator/geolocator.dart';

import 'package:flutter/cupertino.dart';

/**********************************************************************
*    Title: Cloud Firestore Documentation
*    Author: Google Firebase
*    Date: 2022
*    Availability: https://firebase.google.com/docs/firestore
*
**********************************************************************/

// Database services.
class UserDatabaseServices {

  String uid;
  late CollectionReference userInfoCollection;
  late DocumentReference userInfoDocument;
  
  // Constructor with provided user id.
  UserDatabaseServices(this.uid) {
    userInfoCollection = FirebaseFirestore.instance.collection("user_info");
    userInfoDocument = FirebaseFirestore.instance.collection("user_info").doc(uid);
  }

  // A stream listen to changes in user data.
  Future<DocumentSnapshot<Object?>> getUserData(String uid) async {
    final userData = await userInfoDocument.get();
    return userData;
  }

  // Update user data. (Front end not implemented in final project.)
  Future updateUserData(String username, String address, String phoneNumber) async {
    await userInfoCollection.doc(uid).set({
      'username': username,
      'address': address,
      'phone_number': phoneNumber
    });
  }

  // Get user information list from snapshot. (Front end not implemented in final project.)
  List<UserInformation> _userInformationFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInformation(
        username: doc["username"] ?? 'not set', 
        address: doc["address"] ?? 'not set', 
        phoneNumber: doc["phone_number"] ?? -1,
      );
    }).toList();
  }

  // Get snapshots from google firebase collection. (Front end not implemented in final project.)
  Stream<List<UserInformation>> get test {
    return userInfoCollection.snapshots().map(_userInformationFromSnapshot);
  }

  // Get snapshots of this user from google firebase collection. (Front end not implemented in final project.)
  Stream<DECOUser> get testUserData {
    return userInfoCollection.doc(uid).snapshots().map(_decoUserInformationFromSnapshot);
  }

  // Generate DECO user information model from snapshot. (Front end not implemented in final project.)
  DECOUser _decoUserInformationFromSnapshot(DocumentSnapshot snapshot) {
    return DECOUser(
      uid: uid, 
      username: snapshot['username'], 
      address: snapshot['address'], 
      phoneNumber: snapshot['phone_number']
    );
  }

  // Save a post to database with the provided parameters.
  savePost(List<dynamic> files, brief, feature, description, List<double> location) async {

    FirebaseFirestore db = FirebaseFirestore.instance;
    FileServices fileServices = FileServices(uid: uid);
    int fileNumber = 0;
    Map uploadFiles = {};
    Map imagePaths = {};
    Map tempImagePaths = {};

    for (var file in files) {
      if (file != null) {
        fileNumber += 1;
        tempImagePaths["image_$fileNumber"] = "path_$fileNumber";
        uploadFiles["image_$fileNumber"] = file;
      }
    }

    final post = <String, dynamic>{
      "user_id": uid,
      "date": DateTime.now(),
      "brief": brief,
      "location": location,
      "feature_tag": feature,
      "description": description,
      "image_paths": imagePaths,

      // By our concept and consideration of ethical issues, this value should be input by the user. (User should be able to decide if they want other people see their location, but since front end developers do not built this interface, this value is currently hard coded to true.)
      "display_location": true,

      "voting": 0,
      "voted_user": [],
      "report": 0,
      "is_identified": false,
    };

    // Save this post to the database.
    db.collection("post").add(post).then((value) async {

      String pid = value.id;
      for (var file in uploadFiles.entries) {

        String fileName = file.key;
        // Store uploaded images into storage.
        await fileServices.uploadFiles(file.value, pid, fileName);    
        imagePaths[file.key] = '$uid/$pid/$fileName.jpg';

      }

      // Update image paths in database, it's default value is empty.
      await db.collection("post").doc(value.id).update({"image_paths": imagePaths});

    },);
  }

  // Get the most recent 5 post.
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPost() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var posts = db.collection("post").orderBy("date", descending: true).limit(
        5);
    var docs = await posts.get().then((value) {
      return value.docs;
    },);
    return docs;
  }

  // Get images uploaded by this user.
  Future<List<Image>> getImagesByUser() async {

    FirebaseFirestore db = FirebaseFirestore.instance;
    FileServices fileServices = FileServices(uid: this.uid);
    var uid = this.uid;
    List imagePaths = [];
    List<Image> images = [];

    var posts = db.collection("post").where("user_id", isEqualTo: uid);

    imagePaths = await posts.get().then((value) {
      var imagePaths = [];
      for (var doc in value.docs) {
        Map<dynamic, dynamic> imagePathsOfPost = doc.data()["image_paths"];
        for (var imagePath in imagePathsOfPost.values) {
          imagePaths.add(imagePath);
        }
      }
      return imagePaths;
    },);

    for (var imagePath in imagePaths) {
      Image image = await fileServices.getImageByUrl(imagePath).then((value) => value);
      images.add(image);
    }

    return images;

  }

  // Get current location of this device.
  Future<Position> getGeolocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  // Vote for a particular post with post id.
  Future<bool> vote(String pid) async {

    FirebaseFirestore db = FirebaseFirestore.instance;
    final ref = db.collection("post").doc(pid);

    int currentVoting = await ref.get().then((value) {
      return value.data()!["voting"];
    });
    List currentVotedUser = await ref.get().then((value) {
      return value.data()!["voted_user"];
    });

    // Each user can only vote each post one time, press again will cancel this vote.
    if (!currentVotedUser.contains(uid)) {
      currentVotedUser.add(uid);
      await ref.update({"voting": currentVoting + 1});
      await ref.update({"voted_user": currentVotedUser});
      return true;
    } else {
      currentVotedUser.remove(uid);
      await ref.update({"voting": currentVoting - 1});
      await ref.update({"voted_user": currentVotedUser});
      return false;
    }

  }

  // Identify for a particular post with post id.
  Future<bool> identify(String pid) async {

    FirebaseFirestore db = FirebaseFirestore.instance;
    final ref = db.collection("post").doc(pid);

    int currentVoting = await ref.get().then((value) {
      return value.data()!["voting"];
    });
    List currentVotedUser = await ref.get().then((value) {
      return value.data()!["voted_user"];
    });

    if (!currentVotedUser.contains(uid)) {
      currentVotedUser.add(uid);
      await ref.update({"voting": currentVoting + 1});
      await ref.update({"voted_user": currentVotedUser});
      return true;
    } else {
      currentVotedUser.remove(uid);
      await ref.update({"voting": currentVoting - 1});
      await ref.update({"voted_user": currentVotedUser});
      return false;
    }

  }

}