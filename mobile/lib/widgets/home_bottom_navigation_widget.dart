import 'package:flutter/material.dart';

class HomeBottomNavigationWidget extends StatelessWidget {
  final void Function(int) onItemTapped;
  final int selectedIndex;

  const HomeBottomNavigationWidget(
      {Key? key, required this.onItemTapped, required this.selectedIndex})
      : super(key: key);

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

    //   return BottomNavigationBar(
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.photo),
    //         label: '写真',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.camera),
    //         label: 'カメラ',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings),
    //         label: '設定',
    //       ),
    //     ],
    //     currentIndex: selectedIndex,
    //     onTap: onItemTapped,
    //   );
  }
}
