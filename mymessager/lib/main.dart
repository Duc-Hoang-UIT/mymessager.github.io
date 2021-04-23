import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/views/LoginPage.dart';
import 'package:mymessager/views/Register_Page.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = "My Messager";
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        "/": (context) => LoginPage(),
        "/regis": (context) => RegisterPage(),
      },
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: "/",
    );
  }
}
