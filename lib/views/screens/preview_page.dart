import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hungry/views/utils/AppColor.dart';
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
        title: Text('Image Preview', style: TextStyle(fontFamily: 'inter', color: AppColor.secondary)),
        backgroundColor: AppColor.primary,
      ),
      body: Stack(
        children: [
          // Setting a background color for the Scaffold body
          Container(
            color: AppColor.primary, // Adjust this to your desired background color
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Image.file(
              widget.image,
              fit: BoxFit.cover, // Ensures the image covers the entire area
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColor.primary, // Set the background color of the bottom navigation bar
        padding: const EdgeInsets.all(16.0), // Padding for the navigation bar content
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimize the height to fit content
          children: [
            Text(
              'Image to be Scanned',
              style: TextStyle(
                color: AppColor.secondary, // Text color for the label
                fontWeight: FontWeight.bold,
                fontFamily: 'inter',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10), // Space between the text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: retakePicture,
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.secondary, // Background color for the button
                  ),
                  child: Text(
                    'Retake',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'inter',
                      color: AppColor.primary, // Text color
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : uploadImage,
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.secondary, // Background color for the button
                  ),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'inter',
                      color: AppColor.primary, // Text color
                    ),
                  ),
                ),
              ],
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
