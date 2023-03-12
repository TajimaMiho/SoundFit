import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycloud/models/shop.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/view/top/place/place_list_page/place_list_page_controller.dart';

import 'package:mycloud/view/top/place/place_add/add_shop_page.dart';
import 'package:provider/provider.dart';

class ShopListPage {
  static Widget page() {
    return const _ShopListPage();
  }
}

class _ShopListPage extends StatelessWidget {
  const _ShopListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('席一覧')),
    );
  }

  Widget buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            buildList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    final _shopListPageController = ShopListPageController();
    return Consumer(builder: (context, ref, _) {
      final shops = ref.watch(shopListPageProvider.select((s) => s.shop));
      return Column(
        children: shops.reversed.map(buildListItem).toList(),
      );
    });
  }

  Widget buildListItem(Shop shops) {
    return Consumer(
      builder: (context, ref, _) {
        if (shops == null) {
          return CircularProgressIndicator();
        }

        final widgets = ListTile(
          leading: shops.imgURL != null ? Image.network(shops.imgURL!) : null,
          title: Text(shops.title),
          subtitle: Text(shops.author),
          //onTap: goToPlace,
        );
        return (widgets);
      },
    );
  }
  /* @override
  Widget build(BuildContext context) {
    Future<void> goToPlace() async {
      await Navigator.of(context)
          .pushNamed('/place_detail', arguments: shop.id);
    }

    return ChangeNotifierProvider<ShopListModel>(
      create: (_) => ShopListModel()..fetchShopList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '席一覧',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Consumer<ShopListModel>(builder: (context, model, child) {
            final List<Shop>? shops = model.shops;

            if (shops == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = shops
                .map(
                  (shop) => ListTile(
                    leading: shop.imgURL != null
                        ? Image.network(shop.imgURL!)
                        : null,
                    title: Text(shop.title),
                    subtitle: Text(shop.author),
                    onTap: goToPlace,
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<ShopListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddShopPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('席を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchShopList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }*/
}
