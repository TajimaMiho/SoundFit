import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/view/top/add/add_shop_model.dart';
import 'package:provider/provider.dart';

class AddShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddShopModel>(
      create: (_) => AddShopModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本を追加'),
        ),
        body: Center(
          child: Consumer<AddShopModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本の著者',
                    ),
                    onChanged: (text) {
                      model.author = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // 追加の処理
                      try {
                        await model.addShop();
                        Navigator.of(context).pop(true);
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text('追加する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
