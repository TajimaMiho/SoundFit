import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/provider/login_provider.dart';
import 'package:mycloud/service/will_pop_call_back.dart';

double titleSize = 24.0;

final userInputProvider = StateProvider<String>((ref) {
  return '';
});

class TopPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      //前のページに戻らせたくない時に使う
      onWillPop: willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Serch'),
        ),
        body: Container(),
      ),
    );
  }
}
