import 'package:flutter/material.dart';
import '../widgets/image_upload_widget.dart';
import '../widgets/home_bottom_navigation_widget.dart';

class HomeUploadPicturesScreen extends StatefulWidget {
  const HomeUploadPicturesScreen({Key? key}) : super(key: key);

  @override
  _HomeUploadPicturesScreenState createState() =>
      _HomeUploadPicturesScreenState();
}

class _HomeUploadPicturesScreenState extends State<HomeUploadPicturesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    ));
  }
}
