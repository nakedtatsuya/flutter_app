import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_app/providers/user.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (context) => UserProvider()),
  //   ],
  //   child: const MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Mosaic App';
    return MaterialApp(
      title: title,
      home: const MyHomePage(title: title),
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "NotoSansJP"),
    );
  }
}
