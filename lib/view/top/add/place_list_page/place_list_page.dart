import 'package:flutter/material.dart';
import 'package:mycloud/config/constants.dart';
import 'package:mycloud/models/place_list.dart';
import 'package:mycloud/view/top/add/place_detail/place_detail.dart';
import 'package:mycloud/view/top/add/place_list_page/place_list_page_model.dart';
import 'package:mycloud/view/top/add/place_add/add_place_page.dart';
import 'package:provider/provider.dart';

class ShopListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;
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
                .map((shop) => buildListItem(
                    shortestSide, shop.title, shop.author, shop.imgURL))
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
  }

  Widget buildListItem(
      double shortestSide, String title, String author, String? imgURL) {
    final Image image = Image.network(imgURL!);
    return Consumer(builder: (context, ref, _) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlaceDetailPage(shoptitle: title)),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: appShadow,
          ),
          child: Column(
            children: [
              Image.network(
                imgURL,
                width: shortestSide / 2,
              ),
              Text(title),
              Text(author),
            ],
          ),
        ),
      );
    });
  }
}
