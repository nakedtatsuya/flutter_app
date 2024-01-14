import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mosaic_app/models/photo.dart';
import 'package:mosaic_app/widgets/grid_photos_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import '../widgets/image_upload_widget.dart';

class PhotoEditScreen extends StatefulWidget {
  final AssetEntity photo;
  const PhotoEditScreen({super.key, required this.photo});
  @override
  _PhotoEditScreenState createState() => _PhotoEditScreenState(photo);
}

class _PhotoEditScreenState extends State<PhotoEditScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  // Declare a field that holds the Todo.
  final AssetEntity photo;
  _PhotoEditScreenState(this.photo);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _onPressed() {
    setState(() {
      // _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        // title: const Text('写真編集'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // _showActionSheet(context);
            },
          ),
        ],
      ),
      body: SizedBox(
        width: screenWidth, // 横幅いっぱい
        child: FutureBuilder<Uint8List?>(
            future: photo.thumbnailData,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.contain,
                  // width: 100,
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _onPressed, child: const Icon(Icons.upload)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.filter),
            label: '除外',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'モザイク',
          ),
        ],
        onTap: (int index) {
          // _onItemTapped(index);
        },
      ),
    );
  }
}

class MyCustomActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showActionSheet(context);
      },
      child: Icon(Icons.more_vert),
    );
  }

  void _showActionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.share),
                    title: Text('共有'),
                    onTap: () {
                      // 共有のアクションを実装
                      Navigator.pop(context);
                    }),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('削除'),
                  onTap: () {
                    // 削除のアクションを実装
                    Navigator.pop(context);
                  },
                ),
                // 他のアクションを追加...
              ],
            ),
          );
        });
  }
}
