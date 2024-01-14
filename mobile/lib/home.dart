import 'package:flutter/material.dart';
import 'package:mosaic_app/screens/upload_pictures_screen.dart';

import 'widgets/home_bottom_navigation_widget.dart';
import 'screens/device_pictures_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // futurePicture = NetworkService.fetchJSON();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: const TabBarView(
            children: [
              UploadPicturesScreen(),
              DevicePicturesScreen(),
              Text('カメラ'),
              Text('設定'),
            ],
          ),
          bottomNavigationBar: const HomeBottomNavigationWidget(),
        ));
  }
}
