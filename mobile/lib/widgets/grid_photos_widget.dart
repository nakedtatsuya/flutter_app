import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mosaic_app/screens/photo_edit_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class GridPhotos extends StatelessWidget {
  final List<AssetEntity> pictures;
  const GridPhotos({Key? key, required this.pictures});

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
                return GestureDetector(
                    child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PhotoEditScreen(photo: pictures[index]),
                            ),
                          )
                        });
              }
              return const Center(child: CircularProgressIndicator());
            });
      },
    ));
  }
}
