import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Mosaic App';
    return MaterialApp(
      title: title,
      home: MyHomePage(title: title),
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "NotoSansJP"),
    );
  }
}
