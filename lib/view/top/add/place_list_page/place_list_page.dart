import 'package:flutter/material.dart';
import 'package:mycloud/config/constants.dart';
import 'package:mycloud/config/them_text.dart';
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
                    shortestSide,
                    shop.title,
                    shop.author,
                    shop.imgURL,
                    shop.cry,
                    shop.electronic,
                    shop.cashRegister,
                    shop.ventilationFan,
                    shop.keyboard,
                    shop.masticatory))
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
      double shortestSide,
      String title,
      String author,
      String? imgURL,
      int cry,
      int electronic,
      int cashRegister,
      int ventilationFan,
      int keyboard,
      int masticatory) {
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
              BlackText(title, 24),
              BlackText(author, 24),
              /*BlackText("cry", 24),
              BlackText("electronic", 24),
              BlackText("cashRegister", 24),
              BlackText("ventilationFan", 24),
              BlackText("keyboard", 24),
              BlackText("masticatory", 24),*/
              buildSoundDetail("cry", cry),
              buildSoundDetail("electronic", electronic),
              buildSoundDetail("cashRegister", cashRegister),
              buildSoundDetail("ventilationFan", ventilationFan),
              buildSoundDetail("keyboard", keyboard),
              buildSoundDetail("masticatory", masticatory),
            ],
          ),
        ),
      );
    });
  }

  Widget buildSoundDetail(String shoJyoNm, int react) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlackText(shoJyoNm, 24),
          react == 0
              ? Icon(Icons.sentiment_very_satisfied, color: Colors.green)
              : react == 1
                  ? Icon(Icons.sentiment_satisfied, color: Colors.lightGreen)
                  : react == 2
                      ? Icon(Icons.sentiment_neutral, color: Colors.amber)
                      : react == 3
                          ? Icon(Icons.sentiment_dissatisfied,
                              color: Colors.redAccent)
                          : react == 4
                              ? Icon(Icons.sentiment_very_dissatisfied,
                                  color: Colors.red)
                              : Icon(Icons.question_mark)
        ],
      ),
    );
  }
}
