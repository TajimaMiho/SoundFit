import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycloud/models/shop_list_class.dart';

class ShopListModel extends ChangeNotifier {
  List<Shop>? shops;

  void fetchShopList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shops').get();

    final List<Shop> shops = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String author = data['author'];
      final String? imgURL = data['imgURL'];
      return Shop(id, title, author, imgURL);
    }).toList();

    this.shops = shops;
    notifyListeners();
  }
}
