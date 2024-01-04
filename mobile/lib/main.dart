import 'package:flutter/material.dart';
import 'screens/my_home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Mosaic App';
    return const MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}
