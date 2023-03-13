import 'package:flutter/material.dart';
import 'package:mycloud/view/top/add/place_detail/place_detail_controller.dart';
import 'package:mycloud/models/place_list.dart';
import 'package:mycloud/view/top/add/place_list_page/place_list_page_model.dart';

import 'package:mycloud/view/top/add/place_add/add_place_page.dart';
import 'package:provider/provider.dart';

class PlaceDetailPage extends StatelessWidget {
  final String shoptitle;

  PlaceDetailPage({required this.shoptitle});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopListModel>(
      create: (_) => ShopListModel()..fetchShopList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            shoptitle,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Consumer<ShopListModel>(
          builder: (context, model, child) {
            final List<Shop>? shops = model.shops;

            if (shops == null) {
              return CircularProgressIndicator();
            }

            final filteredShops =
                shops.where((shop) => shop.title == shoptitle);

            final List<Widget> widgets = filteredShops
                .map(
                  (shop) => ListTile(
                    leading: shop.imgURL != null
                        ? Image.network(shop.imgURL!)
                        : null,
                    title: Text(shop.title),
                    subtitle: Text(shop.author),
                  ),
                )
                .toList();

            return ListView(
              children: widgets,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
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

            final model = Provider.of<ShopListModel>(context, listen: false);
            model.fetchShopList();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
