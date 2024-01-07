import 'package:flutter/material.dart';

class HomeBottomNavigationWidget extends StatelessWidget {
  const HomeBottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(icon: Icon(Icons.home), text: 'ホーム'),
        Tab(icon: Icon(Icons.photo), text: '写真'),
        Tab(icon: Icon(Icons.camera), text: 'カメラ'),
        Tab(icon: Icon(Icons.settings), text: '設定'),
      ],
    );
  }
}
