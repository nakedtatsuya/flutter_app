import 'package:flutter/material.dart';

class GridPictures extends StatelessWidget {
  final List<String> pictures;
  const GridPictures({Key? key, required this.pictures});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 一行に表示するアイテムの数
        crossAxisSpacing: 4, // 水平方向のスペース
        mainAxisSpacing: 4, // 垂直方向のスペース
      ),
      itemCount: pictures.length,
      itemBuilder: (context, index) {
        return Image.asset(
          pictures[index],
          fit: BoxFit.cover,
        );
      },
    ));
  }
}
