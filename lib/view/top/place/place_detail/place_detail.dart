import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/models/shop.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/view/top/place/place_list_page/place_list_page_controller.dart';

import 'package:mycloud/view/top/place/place_add/add_shop_page.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends ConsumerWidget {
  PlaceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Shop shop = ref.watch(shop.id).;
    final int index = ModalRoute.of(context)!.settings.arguments as int;

    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;

    return Scaffold(
      appBar: AppBar(
        title: Text("詳細"),
      ),
      body: (Text("詳細")),

      //  SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Text(
      //         '【${newsList[index].title}】',
      //         style: TextStyle(
      //             fontSize: shortestSide / 22, color: Styles.commonTextColor),
      //         textAlign: TextAlign.left,
      //       ),
      //       ThumbnailImage(
      //           shortestSide, shortestSide / 1.63, newsList[index].path),
      //       Text(
      //         newsList[index].description,
      //         style: TextStyle(
      //             fontSize: shortestSide / 22, color: Styles.commonTextColor),
      //         textAlign: TextAlign.center,
      //       ),
      //       Text(
      //         newsList[index].address,
      //         style: TextStyle(
      //             fontSize: shortestSide / 22, color: Styles.commonTextColor),
      //         textAlign: TextAlign.center,
      //       )
      //     ],
      //   ),
      // )
    );
  }
}
