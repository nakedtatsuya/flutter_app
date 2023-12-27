import 'package:flutter/material.dart';
import '../widgets/image_upload_widget.dart';
import '../models/picture.dart';
import '../services/network_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Picture> futurePicture;

  @override
  void initState() {
    super.initState();
    futurePicture = NetworkService.fetchJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageUploadWidget(),
            FutureBuilder<Picture>(
              future: futurePicture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text(snapshot.data!.imageString);
                } else {
                  return const Text('No data');
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      )),
    );
  }
}
