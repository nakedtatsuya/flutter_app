import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
// jsonDecode
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class Album {
  final int itemId;
  final String q;
  final String hoge;

  const Album({
    required this.itemId,
    required this.q,
    required this.hoge,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'item_id': int userId,
        'q': String q,
        'hoge': String hoge,
      } =>
        Album(
          itemId: userId,
          q: q,
          hoge: hoge,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

Future<Album> fetchJSON() async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/items/2?q=hoge&hoge=aaaaaaa'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            // Image.asset('images/output.jpg'),
            ImageUploadWidget(),

            FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.q);
                } else if (snapshot.hasError) {
                  print('${snapshot.error}');
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_image != null) Image.file(File(_image!.path)),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('aaaaa'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_image != null) {
              uploadImage(_image!.path);
            }
          },
          child: Text('画像をアップロード'),
        ),
      ],
    );
  }
}

Future<void> uploadImage(String filePath) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://127.0.0.1:8000/pictures'));
  request.files.add(await http.MultipartFile.fromPath('file', filePath));

  var response = await request.send();

  if (response.statusCode == 200) {
    print('アップロード成功');
  } else {
    print('アップロード失敗: ${response.statusCode}');
  }
}
