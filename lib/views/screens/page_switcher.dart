import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hungry/views/screens/bookmarks_page.dart';
import 'package:hungry/views/screens/camera_page.dart'; // Import the new CameraPage
import 'package:hungry/views/screens/home_page.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:hungry/views/widgets/custom_bottom_navigation_bar.dart';

class PageSwitcher extends StatefulWidget {
  @override
  _PageSwitcherState createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  int _selectedIndex = 0;
  late Future<List<CameraDescription>> camerasFuture;

  @override
  void initState() {
    super.initState();
    // Load the cameras asynchronously
    camerasFuture = availableCameras();
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: FutureBuilder<List<CameraDescription>>(
        future: camerasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for cameras to initialize
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors during initialization
            return Center(child: Text('Error loading cameras'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle case when no cameras are found
            return Center(child: Text('No cameras available'));
          }

          // Cameras have been successfully initialized
          final cameras = snapshot.data!;

          return Stack(
            children: [
              [
                HomePage(),
                CameraPage(cameras: cameras), // Use the initialized cameras
                BookmarksPage(),
              ][_selectedIndex],
              BottomGradientWidget(),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

class BottomGradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(gradient: AppColor.bottomShadow),
      ),
    );
  }
}
