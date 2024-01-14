import 'package:flutter/material.dart';
import 'package:mosaic_app/widgets/grid_photos_widget.dart';
import 'package:mosaic_app/widgets/image_upload_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class DevicePhotosScreen extends StatefulWidget {
  const DevicePhotosScreen({Key? key}) : super(key: key);

  @override
  _DevicePhotosScreenState createState() => _DevicePhotosScreenState();
}

class _DevicePhotosScreenState extends State<DevicePhotosScreen> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageUploadWidget(),
        GridPhotos(pictures: _photos),
      ],
    );
  }
}
