import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/top_page_route.dart';
import 'package:mycloud/view/login.dart';
import 'package:mycloud/view/top/top_page.dart';

class SoundFit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Top(),
        '/login': (BuildContext context) => Top(),
        '/top': (BuildContext context) => Top(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Title',
      theme: ThemeData(
        primarySwatch: Styles.primarySwatch,
        primaryColor: Styles.primaryColor,
        brightness: Brightness.light,
        backgroundColor: Styles.pageBackground,
        appBarTheme: Styles.appBarTheme,
        scaffoldBackgroundColor: Styles.pageBackground,
        textTheme: GoogleFonts.mPlusRounded1cTextTheme(
          Styles.textTheme,
        ),
      ),
    );
  }
}

Future<void> errorPage(String err, BuildContext context) async {
  await Navigator.of(context).pushNamed('/error', arguments: err);
}

class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        //FirebaseAuth インスタンスのログイン状態の変更を監視
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //ローディング中は真ん中にぐるぐるを表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            //userがnullでない、つまりサインイン済み
            return TopPageRoute();
          }
          //userがnull、つまり未サインイン
          return LoginPage();
        },
      ),
    );
  }
}
