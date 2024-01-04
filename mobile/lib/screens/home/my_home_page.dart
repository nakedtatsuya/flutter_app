import 'package:flutter/material.dart';
import '../../widgets/image_upload_widget.dart';
import '../../models/picture.dart';
import '../../services/network_service.dart';
import '../../widgets/home_bottom_navigation_widget.dart';
import '../home_device_pictures_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // late Future<Picture> futurePicture;

  @override
  void initState() {
    super.initState();
    // futurePicture = NetworkService.fetchJSON();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // ここで各ボタンのアクションを定義します。
    switch (index) {
      case 0:
        // デバイスの写真一覧を表示
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DevicePicturesScreen()),
        );
        break;
      case 1:
        // カメラを起動
        break;
      case 2:
        // 設定画面へ
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageUploadWidget(),
                // FutureBuilder<Picture>(
                //   future: futurePicture,
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const CircularProgressIndicator();
                //     } else if (snapshot.hasError) {
                //       return Text('${snapshot.error}');
                //     } else if (snapshot.hasData) {
                //       return Text(snapshot.data!.imageString);
                //     } else {
                //       return const Text('No data');
                //     }
                //   },
                // ),
                const SizedBox(height: 24),
              ],
            ),
          )),
          bottomNavigationBar: HomeBottomNavigationWidget(
            onItemTapped: _onItemTapped,
            selectedIndex: _selectedIndex,
          ),
        ));
  }
}
