import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  final void Function(int) onItemTapped;
  final int selectedIndex;

  const BottomNavigationWidget(
      {Key? key, required this.onItemTapped, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.photo),
          label: '写真',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'カメラ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '設定',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
