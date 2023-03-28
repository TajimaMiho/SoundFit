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
  String situation = 'Alone to relax';
  String timezone = 'Lunch(11:00~14:00)';
  String seatforme = 'Booth';
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
            'Add a seat',
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
                        TextField(
                          maxLength: 20,
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
                            labelText: 'Location',
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
                        SizedBox(
                          height: 24,
                        ),
                        Row(children: [
                          BlackText('Time of visit : ', 24),
                        ]),
                        SizedBox(height: 5),
                        buildtimezone(shortestSide),
                        SizedBox(
                          height: 24,
                        ),
                        Row(children: [
                          BlackText('Seating : ', 24),
                        ]),
                        SizedBox(height: 5),
                        buildseatform(shortestSide),
                        SizedBox(
                          height: 24,
                        ),
                        Row(children: [
                          BlackText('Purpose : ', 24),
                        ]),
                        SizedBox(height: 5),
                        buildsituation(shortestSide),
                        SizedBox(
                          height: 48,
                        ),
                        buildevaluation(shortestSide, "Electronic sounds",
                            model.electronic, 0),
                        buildevaluation(
                            shortestSide, "Fan noise", model.ventilationFan, 1),
                        buildevaluation(shortestSide, "Chewing sound",
                            model.masticatory, 2),
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
                            child: WhiteText('Add!', 24),
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
          BlackText(sound, 24),
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
            value: 'Alone to relax',
            child: BlackText('Alone to relax', 24),
          ),
          DropdownMenuItem(
            value: 'Study ',
            child: BlackText('Study ', 24),
          ),
          DropdownMenuItem(
            value: 'With family/kids',
            child: BlackText('With family/kids', 24),
          ),
          DropdownMenuItem(
            value: 'With friends/co-workers',
            child: BlackText('With friends/co-workers', 24),
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
            value: 'Morning(7:00~11:00)',
            child: BlackText('Morning(7:00~11:00)', 24),
          ),
          DropdownMenuItem(
            value: 'Lunch(11:00~14:00)',
            child: BlackText('Lunch(11:00~14:00)', 24),
          ),
          DropdownMenuItem(
            value: 'Evening(14:00~18:00)',
            child: BlackText('Evening(14:00~18:00)', 24),
          ),
          DropdownMenuItem(
            value: 'Dinner(18:00~22:00)',
            child: BlackText('Dinner(18:00~22:00)', 24),
          ),
          DropdownMenuItem(
            value: 'Late night(22:00~24:00)',
            child: BlackText('Late night(22:00~24:00)', 24),
          ),
          DropdownMenuItem(
            value: 'All day',
            child: BlackText('All day', 24),
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
            value: 'Booth',
            child: BlackText('Booth', 24),
          ),
          DropdownMenuItem(
            value: 'Loose',
            child: BlackText('Loose', 24),
          ),
          DropdownMenuItem(
            value: 'Bench',
            child: BlackText('Bench', 24),
          ),
          DropdownMenuItem(
            value: 'Counter',
            child: BlackText('Counter', 24),
          ),
          DropdownMenuItem(
            value: 'Private room',
            child: BlackText('Private room', 24),
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
}
