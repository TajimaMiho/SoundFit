import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/config/them_text.dart';
import 'package:mycloud/view/top/add/place_add/add_place_model.dart';
import 'package:provider/provider.dart';

class AddShopPage extends StatefulWidget {
  late final LatLng latLng;

  AddShopPage({required this.latLng});
  @override
  _AddShopPage createState() => _AddShopPage(latLng: latLng);
}

class _AddShopPage extends State<AddShopPage> {
  late final LatLng latLng;

  _AddShopPage({required this.latLng});
  late List<double> _rating = [0, 0, 0, 0, 0, 0];
  double _initialRating = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) _rating[i] = _initialRating;
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
                            hintText: '席の位置',
                          ),
                          onChanged: (text) {
                            model.title = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        buildevaluation(shortestSide, "cry", model.cry, 0),
                        buildevaluation(
                            shortestSide, "electronic", model.electronic, 1),
                        buildevaluation(shortestSide, "cashRegister",
                            model.cashRegister, 2),
                        buildevaluation(shortestSide, "ventilationFan",
                            model.ventilationFan, 3),
                        buildevaluation(
                            shortestSide, "keyboard", model.keyboard, 4),
                        buildevaluation(
                            shortestSide, "masticatory", model.masticatory, 5),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // 追加の処理
                            try {
                              model.cry = _rating[0] as int;
                              model.electronic = _rating[1] as int;
                              model.cashRegister = _rating[2] as int;
                              model.ventilationFan = _rating[3] as int;
                              model.keyboard = _rating[4] as int;
                              model.masticatory = _rating[5] as int;
                              model.latLng = latLng;
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
}
