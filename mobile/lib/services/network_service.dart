import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/picture.dart';

class NetworkService {
  static Future<Picture> fetchJSON() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/items/2?q=hoge&hoge=aaaaaaa'));

    if (response.statusCode == 200) {
      return Picture.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load picture');
    }
  }

  static Future<Picture> uploadImage(String filePath) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/pictures'));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print('Upload successful');
      return Picture.fromJson(jsonDecode(responseData) as Map<String, dynamic>);
    } else {
      print('Upload failed: ${response.statusCode}');
      return Picture.fromJson(jsonDecode(responseData) as Map<String, dynamic>);
    }
  }
}
