import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mosaic_app/widgets/grid_pictures_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import '../widgets/image_upload_widget.dart';

class UploadPicturesScreen extends StatefulWidget {
  const UploadPicturesScreen({Key? key}) : super(key: key);

  @override
  _UploadPicturesScreenState createState() => _UploadPicturesScreenState();
}

class _UploadPicturesScreenState extends State<UploadPicturesScreen> {
  List<AssetEntity> _photos = [];
  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  Future<void> _fetchPhotos() async {
    final permitted = await PhotoManager.requestPermissionExtend();
    if (permitted.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();
      List<AssetEntity> photos =
          await albums[0].getAssetListPaged(page: 0, size: 100);
      setState(() {
        _photos = photos;
      });
    } else {
      await PhotoManager.openSetting(); // Request permission again
    }
  }

  @override
  Widget build(BuildContext context) {
    final pictures = [
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
      "assets/images/input.jpg",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageUploadWidget(),
        GridPictures(pictures: _photos),
        const SizedBox(height: 24),
      ],
    );
  }
}
