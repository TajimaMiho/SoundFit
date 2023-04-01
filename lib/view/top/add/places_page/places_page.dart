import 'package:flutter/material.dart';
import 'package:mycloud/config/constants.dart';
import 'package:mycloud/config/them_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mycloud/provider/place_detail/place_detail_provider.dart';

class ShopListPage extends StatelessWidget {
  final String shoptitle;
  final double lat;
  final double long;

  ShopListPage(
      {required this.shoptitle, required this.lat, required this.long});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool pin = false;
    double shortestSide = size.shortestSide;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seat List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            final shops = ref.watch(placeDetailProvider);
            if (shops == null) {
              return CircularProgressIndicator();
            }
            //final filteredShops = shops.where((shop) => (lat == shop.lat));
            if (shops == null) pin = true;
            print('////////////////////////////');
            print(shops);
            print('////////////////////////////');
            final List<Widget> widgets = shops
                .map((shop) => buildListItem(
                    shortestSide,
                    shop.title,
                    shop.imgURL,
                    shop.electronic,
                    shop.ventilationFan,
                    shop.masticatory,
                    shop.situation,
                    shop.timezone,
                    shop.seatforme))
                .toList();
            return ListView(
              children: widgets,
            );
          },
        ),
      ),
    );
  }

  Widget buildListItem(
    double shortestSide,
    String title,
    String? imgURL,
    int electronic,
    int ventilationFan,
    int masticatory,
    String situation,
    String timezone,
    String seatforme,
  ) {
    final Image image = Image.network(imgURL!);
    return Consumer(builder: (context, ref, _) {
      return GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
              SizedBox(
                height: 12,
              ),
              buildSeatDetail("Purpose", situation),
              buildSeatDetail("Time of visit", timezone),
              buildSeatDetail("Location", title),
              buildSeatDetail("Seating", seatforme),
              buildSoundDetail("Electronic sounds", electronic),
              buildSoundDetail("Fan noise", ventilationFan),
              buildSoundDetail("Chewing sound", masticatory),
              SizedBox(
                height: 12,
              ),
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
          BlackText(shoJyoNm, 18),
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

  Widget buildSeatDetail(String content, String content_d) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlackText(content, 18),
          BlackText(content_d, 18),
        ],
      ),
    );
  }
}
