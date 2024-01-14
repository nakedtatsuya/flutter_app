import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GridPictures extends StatelessWidget {
  final List<AssetEntity> pictures;
  const GridPictures({Key? key, required this.pictures});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 一行に表示するアイテムの数
        crossAxisSpacing: 4, // 水平方向のスペース
        mainAxisSpacing: 4, // 垂直方向のスペース
      ),
      itemCount: pictures.length,
      itemBuilder: (context, index) {
        return FutureBuilder<Uint8List?>(
            future: pictures[index].thumbnailData,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Image.memory(snapshot.data!);
              }
              return const Center(child: CircularProgressIndicator());
            });
      },
    ));
  }
}
