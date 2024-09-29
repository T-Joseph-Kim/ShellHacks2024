import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'camera_page.dart'; // Import CameraPage if you need to navigate back

class PreviewPage extends StatefulWidget {
  final File image;

  const PreviewPage({Key? key, required this.image}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  bool isLoading = false;

  Future<void> uploadImage() async {
    setState(() {
      isLoading = true;
    });

    String url =
        'https://us-central1-automatic-hawk-437002-u3.cloudfunctions.net/getStructuredNutritionFacts/perform_nutrition_label_OCR';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', widget.image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle success
        var responseData = await response.stream.bytesToString();
        print('Response data: $responseData');

        // Navigate to the next page or show success message
        // You can parse the responseData and pass it to the next page if needed
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessPage(data: responseData),
          ),
        );
      } else {
        // Handle failure
        print('Failed to upload image. Status code: ${response.stream}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image. Please try again.')),
        );
      }
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void retakePicture() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Center(
            child: Image.file(widget.image),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: retakePicture,
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              child: Text('Retake'),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : uploadImage,
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  final String data;

  const SuccessPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can parse and display the data as needed
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(data),
      ),
    );
  }
}
