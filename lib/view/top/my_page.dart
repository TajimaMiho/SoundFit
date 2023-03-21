import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/config/them_text.dart';
import 'package:mycloud/models/account/account.dart';
import 'package:mycloud/models/user/user.dart';
import 'package:mycloud/provider/login/login_provider.dart';
import 'package:mycloud/service/providers_provider.dart';

class ConfigPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Account account = ref.watch(accountProvider).account;
    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'アカウント',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Styles.primaryColor700,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            buildNameBand(shortestSide, account),
          ],
        ),
      ),
    );
  }

  Widget buildNameBand(double shortestSide, Account account) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      width: shortestSide / 1.1,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle,
            size: shortestSide / 12,
          ),
          SizedBox(
            width: shortestSide / 20,
          ),
          /*Text(
            account.name,
            style: TextStyle(fontSize: shortestSide / 12),
          ),*/
          BlackText(account.name, shortestSide / 12)
        ],
      ),
    );
  }
}
