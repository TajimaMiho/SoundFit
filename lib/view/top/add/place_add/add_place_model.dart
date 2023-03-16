import 'dart:html' as html;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AddShopModel extends ChangeNotifier {
  String? title;
  bool isLoading = false;
  Uint8List? imageFile;
  int cry = 0;
  int electronic = 0;
  int cashRegister = 0;
  int ventilationFan = 0;
  int keyboard = 0;
  int masticatory = 0;

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

  Future addShop() async {
    if (title == null || title == "") {
      throw 'タイトルが入力されていません';
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
      'imgURL': imgURL,
      'cry': cry,
      'electronic': electronic,
      'cashRegister': cashRegister,
      'ventilationFan': ventilationFan,
      'keyboard': keyboard,
      'masticatory': masticatory,
    });
  }

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
