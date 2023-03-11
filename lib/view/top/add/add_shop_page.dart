import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/view/top/add/add_shop_model.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

/*class AddShopPage extends StatelessWidget {
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
                  GestureDetector(
                    child: SizedBox(
                      width: 100,
                      height: 160,
                      child: model.imageFile != null
                          ? Image.file(model.imageFile!)
                          : Container(
                              color: Colors.grey,
                            ),
                    ),
                    onTap: () {
                      model.pickImage();
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'お店の名前',
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
                      hintText: '場所',
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
}*/

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
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: SizedBox(
                          width: 100,
                          height: 160,
                          child: model.imageFile != null
                              ? Image.memory(model.imageFile!)
                              : Container(
                                  color: Colors.grey,
                                ),
                        ),
                        onTap: () async {
                          print("反応！");
                          await model.pickImage();
                        },
                      ),
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
                            model.startLoading();
                            await model.addShop();
                            Navigator.of(context).pop(true);
                          } catch (e) {
                            print(e);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            model.endLoading();
                          }
                        },
                        child: Text('追加する'),
                      ),
                    ],
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
