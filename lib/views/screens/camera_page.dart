import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:hungry/views/screens/more_details.dart';
import 'package:hungry/views/screens/recipe_detail_page.dart';
import 'dart:convert';
import 'preview_page.dart'; // Import the PreviewPage

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  bool isFlashOn = false;
  bool isRearCamera = true;

  // Image files to hold the three pictures
  File? nutritionImage;
  File? ingredientsImage;
  File? productImage;

  int pictureStep = 0; // To track which picture is being taken

  void startCamera(int camera) {
    cameraController = CameraController(
      widget.cameras[camera],
      ResolutionPreset.high,
      enableAudio: false,
    );
    cameraValue = cameraController.initialize();
  }

  @override
  void initState() {
    super.initState();
    startCamera(0);
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    if (cameraController.value.isTakingPicture || !cameraController.value.isInitialized) {
      return;
    }

    if (isFlashOn == false) {
      await cameraController.setFlashMode(FlashMode.off);
    } else {
      await cameraController.setFlashMode(FlashMode.torch);
    }

    try {
      XFile image = await cameraController.takePicture();

      if (cameraController.value.flashMode == FlashMode.torch) {
        await cameraController.setFlashMode(FlashMode.off);
      }

      // Store the image in the corresponding variable based on step
      if (pictureStep == 0) {
        nutritionImage = File(image.path);
        setState(() {
          pictureStep = 1; // Move to ingredients capture
        });
        _showMessage('Take a picture of the ingredients');
      } else if (pictureStep == 1) {
        ingredientsImage = File(image.path);
        setState(() {
          pictureStep = 2; // Move to front product capture
        });
        _showMessage('Take a picture of the front of the product');
      } else if (pictureStep == 2) {
        productImage = File(image.path);
        await sendImagesToApi();
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  // Function to send the images to your API
  Future<void> sendImagesToApi() async {
    if (nutritionImage != null && ingredientsImage != null && productImage != null) {
      print('Sending images to API...');
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://10.108.246.91:5000/perform_nutrition_ingredient_and_product_OCR'),
        );
        request.files.add(await http.MultipartFile.fromPath('nutrition_file', nutritionImage!.path));
        request.files.add(await http.MultipartFile.fromPath('ingredient_file', ingredientsImage!.path));
        request.files.add(await http.MultipartFile.fromPath('product_file', productImage!.path));

        var response = await request.send();

        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var decodedData = json.decode(responseData);
          print(decodedData);

          // Navigate to the recipes page with the response data
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MoreDetailsPage(apiResponse: decodedData), // Assuming RecipesPage takes 'data' as argument
            ),
          );
        } else {
          _showMessage('Failed to upload images. Please try again.');
        }
      } catch (e) {
        print('Error sending images to API: $e');
        _showMessage('Error connecting to server.');
      }
    } else {
      _showMessage('Please capture all three images.');
    }
  }

  // Show a message to the user
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: CameraPreview(cameraController),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFlashOn = !isFlashOn;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(50, 0, 0, 0),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            isFlashOn ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRearCamera = !isRearCamera;
                        });
                        isRearCamera ? startCamera(0) : startCamera(1);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(50, 0, 0, 0),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            isRearCamera ? Icons.camera_front : Icons.camera_rear,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding + 80),
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(255, 255, 255, .7),
          shape: const CircleBorder(),
          onPressed: takePicture, // Call takePicture here
          child: const Icon(
            Icons.camera_alt,
            size: 40,
            color: Colors.black87,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
