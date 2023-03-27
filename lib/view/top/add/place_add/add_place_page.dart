import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/config/them_text.dart';
import 'package:mycloud/view/top/add/place_add/add_place_model.dart';
import 'package:provider/provider.dart';

class AddShopPage extends StatefulWidget {
  late final double lat;
  late final double long;
  late final bool pin;

  AddShopPage({required this.lat, required this.long, required this.pin});
  @override
  _AddShopPage createState() => _AddShopPage(lat: lat, long: long, pin: pin);
}

class _AddShopPage extends State<AddShopPage> {
  late final double lat;
  late final double long;
  late final bool pin;

  _AddShopPage({required this.lat, required this.long, required this.pin});
  late List<double> _rating = [
    0,
    0,
    0,
  ];
  double _initialRating = 0;
  String situation = '一人で静かに過ごしたい';
  String timezone = '昼';
  String seatforme = '大テーブル';
  String spacebetween = '1.0~2.0m';
  bool isfilled = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) _rating[i] = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;
    return ChangeNotifierProvider<AddShopModel>(
      create: (_) => AddShopModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'お店を追加',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Consumer<AddShopModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        GestureDetector(
                          child: SizedBox(
                            width: 160,
                            height: 256,
                            child: model.imageFile != null
                                ? Image.memory(model.imageFile!)
                                : Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Styles.secondaryColor,
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 0.8,
                                          spreadRadius: 0.8,
                                        ),
                                      ],
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Styles.primaryColor, width: 3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.photo,
                                      size: 80,
                                      color: Styles.secondaryColor,
                                    ),
                                  ),
                          ),
                          onTap: () async {
                            print("反応！");

                            await model.pickImage();
                          },
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 1.0),
                                blurRadius: 0.8,
                                spreadRadius: 0.8,
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: isfilled
                                    ? BorderSide(color: Styles.secondaryColor)
                                    : BorderSide(
                                        color: Styles.errorColor, width: 2.5),
                              ),
                              labelText: '席の位置',
                              labelStyle: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            onChanged: (text) {
                              if (text != null)
                                setState(() {
                                  isfilled = true;
                                });
                              else
                                setState(() {
                                  isfilled = false;
                                });
                              model.title = text;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(children: [
                          BlackText('時間帯 : ', 24),
                        ]),
                        buildtimezone(shortestSide),
                        SizedBox(
                          height: 24,
                        ),
                        Row(children: [
                          BlackText('席の形 : ', 24),
                        ]),
                        buildseatform(shortestSide),
                        SizedBox(
                          height: 24,
                        ),
                        Row(children: [
                          BlackText('隣との間隔 : ', 24),
                        ]),
                        buildspacebetween(shortestSide),
                        SizedBox(
                          height: 24,
                        ),
                        Row(children: [
                          BlackText('利用客の状況 : ', 24),
                        ]),
                        buildsituation(shortestSide),
                        SizedBox(
                          height: 24,
                        ),
                        buildevaluation(
                            shortestSide, "electronic", model.electronic, 0),
                        buildevaluation(shortestSide, "ventilationFan",
                            model.ventilationFan, 1),
                        buildevaluation(
                            shortestSide, "masticatory", model.masticatory, 2),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: shortestSide / 2,
                          height: shortestSide / 5,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 1.0),
                                blurRadius: 0.8,
                                spreadRadius: 0.8,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              // 追加の処理
                              if (pin == false) {
                                await FirebaseFirestore.instance
                                    .collection('places') // コレクションID
                                    .doc()
                                    .set({
                                  'lat': lat,
                                  'long': long,
                                });
                              }

                              try {
                                model.electronic = _rating[0] as int;
                                model.ventilationFan = _rating[1] as int;
                                model.masticatory = _rating[2] as int;
                                model.lat = lat;
                                model.long = long;
                                model.situation = situation;
                                model.timezone = timezone;
                                model.seatforme = seatforme;
                                model.spacebetween = spacebetween;
                                model.startLoading();
                                await model.addShop();
                                Navigator.of(context).pop(true);
                              } catch (e) {
                                print(e);
                                final snackBar = SnackBar(
                                  backgroundColor: Styles.errorColor,
                                  content: Text(e.toString()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } finally {
                                model.endLoading();
                              }
                            },
                            child: WhiteText('追加する', 24),
                          ),
                        ),
                        SizedBox(
                          height: 48,
                        )
                      ],
                    ),
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

  Widget buildevaluation(
      double shortestSide, String sound, int soundData, int index) {
    double iconSize = shortestSide / 10;
    return Container(
      width: shortestSide,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlackText(sound, 36),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.all(iconSize / 2),
                icon: Icon(
                  Icons.sentiment_very_satisfied,
                  color: _rating[index] == 0 ? Colors.green : Colors.grey,
                  size: iconSize,
                ),
                onPressed: () {
                  setState(() {
                    _rating[index] = 0;
                  });
                },
              ),
              IconButton(
                  padding: EdgeInsets.all(iconSize / 2),
                  icon: Icon(
                    Icons.sentiment_satisfied,
                    color:
                        _rating[index] == 1 ? Colors.lightGreen : Colors.grey,
                    size: iconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating[index] = 1;
                    });
                  }),
              IconButton(
                  padding: EdgeInsets.all(iconSize / 2),
                  icon: Icon(
                    Icons.sentiment_neutral,
                    color: _rating[index] == 2 ? Colors.amber : Colors.grey,
                    size: iconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating[index] = 2;
                    });
                  }),
              IconButton(
                  padding: EdgeInsets.all(iconSize / 2),
                  icon: Icon(
                    Icons.sentiment_dissatisfied,
                    color: _rating[index] == 3 ? Colors.redAccent : Colors.grey,
                    size: iconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating[index] = 3;
                    });
                  }),
              IconButton(
                  padding: EdgeInsets.all(iconSize / 2),
                  icon: Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: _rating[index] == 4 ? Colors.red : Colors.grey,
                    size: iconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating[index] = 4;
                    });
                  }),
            ],
          ),
          SizedBox(
            height: iconSize,
          )
        ],
      ),
    );
  }

  Widget buildsituation(double shortestSide) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      width: shortestSide / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1.0, 1.0),
            blurRadius: 0.8,
            spreadRadius: 0.8,
          ),
        ],
      ),
      //color: Styles.secondaryTextColor,
      child: DropdownButton(
        isExpanded: true,
        items: const [
          DropdownMenuItem(
            value: '一人で静かに過ごしたい',
            child: BlackText('一人で静かに過ごしたい', 24),
          ),
          DropdownMenuItem(
            value: '複数人でワイワイ過ごしたい',
            child: BlackText('複数人でワイワイ過ごしたい', 24),
          ),
          DropdownMenuItem(
            value: '作業や勉強に集中したい',
            child: BlackText('作業や勉強に集中したい', 24),
          ),
        ],
        value: situation,
        onChanged: (String? value) {
          setState(() {
            situation = value!;
          });
        },
      ),
    );
  }

  Widget buildtimezone(double shortestSide) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      width: shortestSide / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1.0, 1.0),
            blurRadius: 0.8,
            spreadRadius: 0.8,
          ),
        ],
      ),
      //color: Styles.secondaryTextColor,
      child: DropdownButton(
        isExpanded: true,
        items: const [
          DropdownMenuItem(
            value: '朝',
            child: BlackText('朝', 24),
          ),
          DropdownMenuItem(
            value: '昼',
            child: BlackText('昼', 24),
          ),
          DropdownMenuItem(
            value: '晩',
            child: BlackText('晩', 24),
          ),
        ],
        value: timezone,
        onChanged: (String? value) {
          setState(() {
            timezone = value!;
          });
        },
      ),
    );
  }

  Widget buildseatform(double shortestSide) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      width: shortestSide / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1.0, 1.0),
            blurRadius: 0.8,
            spreadRadius: 0.8,
          ),
        ],
      ),
      //color: Styles.secondaryTextColor,
      child: DropdownButton(
        isExpanded: true,
        items: const [
          DropdownMenuItem(
            value: '大テーブル',
            child: BlackText('大テーブル', 24),
          ),
          DropdownMenuItem(
            value: 'カウンター',
            child: BlackText('カウンター', 24),
          ),
          DropdownMenuItem(
            value: 'ボックス席',
            child: BlackText('ボックス席', 24),
          ),
          DropdownMenuItem(
            value: '個室',
            child: BlackText('個室', 24),
          ),
        ],
        value: seatforme,
        onChanged: (String? value) {
          setState(() {
            seatforme = value!;
          });
        },
      ),
    );
  }

  Widget buildspacebetween(double shortestSide) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      width: shortestSide / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1.0, 1.0),
            blurRadius: 0.8,
            spreadRadius: 0.8,
          ),
        ],
      ),
      //color: Styles.secondaryTextColor,
      child: DropdownButton(
        isExpanded: true,
        items: const [
          DropdownMenuItem(
            value: 'less than 1.0m',
            child: BlackText('less than 1.0m', 24),
          ),
          DropdownMenuItem(
            value: '1.0~2.0m',
            child: BlackText('1.0~2.0m', 24),
          ),
          DropdownMenuItem(
            value: '2.0~3.0m',
            child: BlackText('2.0~3.0m', 24),
          ),
          DropdownMenuItem(
            value: 'more than 3.0m',
            child: BlackText('more than 3.0m', 24),
          ),
        ],
        value: spacebetween,
        onChanged: (String? value) {
          setState(() {
            spacebetween = value!;
          });
        },
      ),
    );
  }
}
