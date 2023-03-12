/*import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';

class AddShopModel extends ChangeNotifier {
  String? title;
  String? author;
  File? imageFile;

  final picker = ImagePicker();

  Future addShop() async {
    if (title == null || title == "") {
      throw 'タイトルが入力されていません';
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('shops').doc();

    final String? imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('shops/${doc.id}')
          .putData(imageFile);
      imgURL = await task.ref.getDownloadURL();
    }

    // firestoreに追加
    await doc.set({
      'title': title,
      'author': author,
      'imgURL': imgURL,
    });
  }

  Future pickImage() async {
    try {
      Uint8List? pickedFile = await ImagePickerWeb.getImageAsBytes();
      if (pickedFile != null) {
        var meta = SettableMetadata(
          contentType: "image/jpeg",
        ) as File?;
        notifyListeners();
        FirebaseStorage.instance.ref("sample").putData(pickedFile, meta);
      }
    } catch (e) {
      print(e);
    }
  }
}*/

//////////////////////////////////////
/*import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddShopModel extends ChangeNotifier {
  String? title;
  String? author;
  File? imageFile;
  bool isLoading = false;

  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addShop() async {
    if (title == null || title == "") {
      throw 'タイトルが入力されていません';
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('shops').doc();

    String? imgURL;
    if (imageFile != null) {
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('shops/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    // firestoreに追加
    await doc.set({
      'title': title,
      'author': author,
      'imgURL': imgURL,
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
*/

import 'dart:html' as html;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AddShopModel extends ChangeNotifier {
  String? title;
  String? author;
  bool isLoading = false;
  Uint8List? imageFile;
  var metadata;

  final picker = ImagePickerWeb();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  /*Future uploadPic() async {
    try {
      String uploadName = 'image.png';
      final storageRef =
          FirebaseStorage.instance.ref().child('users/kkkkk/iiiiiiii');
      final task = await storageRef.putData(imageFile!);
    } catch (e) {
      print(e);
    }
  }*/

  Future addShop() async {
    if (title == null || title == "") {
      throw 'タイトルが入力されていません';
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('shops').doc();

    String? imgURL;
    if (imageFile != null) {
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('shops/${doc.id}')
          .putData(imageFile!, metadata);
      imgURL = await task.ref.getDownloadURL();
    }

    // firestoreに追加
    await doc.set({
      'title': title,
      'author': author,
      'imgURL': imgURL,
    });
  }

  /*Future pickImage() async {
    final pickedFile = await ImagePickerWeb.getImageAsBytes();

    if (pickedFile != null) {
      imageFile = Uint8List(pickedFile.path);
      notifyListeners();
    }
  }*/

  Future pickImage() async {
    imageFile = await ImagePickerWeb.getImageAsBytes();

    if (imageFile != null) {
      metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      notifyListeners();
    }
  }
}
