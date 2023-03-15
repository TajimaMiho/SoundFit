import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycloud/models/place_list.dart';

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
      final int cry = data['cry'];
      final int electronic = data['electronic'];
      final int cashRegister = data['cashRegister'];
      final int ventilationFan = data['ventilationFan'];
      final int keyboard = data['keyboard'];
      final int masticatory = data['masticatory'];
      return Shop(id, title, author, imgURL, cry, electronic, cashRegister,
          ventilationFan, keyboard, masticatory);
    }).toList();

    this.shops = shops;
    notifyListeners();
  }

  void filterByTitle(String title) {
    if (shops == null) return;
    shops = shops!.where((shop) => shop.title == title).toList();
    notifyListeners();
  }
}
