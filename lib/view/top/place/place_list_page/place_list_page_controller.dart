/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycloud/models/shop.dart';

part 'place_list_page_controller.freezed.dart';

@freezed
class ShopListPageState with _$ShopListPageState {
  const factory ShopListPageState({
    @Default(Shop()) Shop shop,
  }) = _ShopListPageState;
}

final shopListPageProvider = StateNotifierProvider.autoDispose<
    ShopListPageController, ShopListPageState>(
  (ref) {
    return ShopListPageController();
  },
);

/*class ShopListPageController extends StateNotifier<ShopListPageState> {
  ShopListPageController() : super(const ShopListPageState()) {
    init();
  }

  Future<void> init() async {
    final shops = await ShopService().fetchList();
    state = state.copyWith(Shop: shops.first);
  }
}*/

class ShopListPageController {
  final _fireStore = FirebaseFirestore.instance;

  Future<Shop> fetchList({required String id}) async {
    final document =
        await FirebaseFirestore.instance.collection('shops').doc(id).get();

    return const Shop().copyWith(
      title: document['title'],
      author: document['author'],
      imgURL: document['imgURL'],
    );
  }
}
