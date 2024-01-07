import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/network_service.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  XFile? _image;
  String? _output;

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
    // var controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse('http://localhost:8000/login/google'));
    return Column(
      children: [
        if (_image != null) Text(_image!.path),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Choose Image'),
        ),
        ElevatedButton(
          onPressed: () async {
            sendGetRequest() async {
              var url = Uri.parse('http://localhost:8000/login/google');
              var response = await http.get(url);

              if (response.statusCode == 200) {
                // Request successful
                print('GET request successful');
                print('Response body: ${response.body}');
              } else {
                // Request failed
                print('GET request failed');
                print('Response status code: ${response.statusCode}');
              }
            }

            await sendGetRequest();
            // if (_image != null) {
            // var res = await NetworkService.uploadImage(_image!.path);
            // setState(() {
            //   _output = res.imageString;
            // });
            // }
          },
          child: const Text('Upload Image'),
        ),
        // WebViewWidget(controller: controller),
        RichText(
          text: TextSpan(
            text: 'Login with Google',
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch('http://localhost:8000/login/google');
              },
          ),
        ),
      ],
    );
  }
}
