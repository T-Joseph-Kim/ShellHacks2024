import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:hungry/views/widgets/modals/login_modal.dart';
import 'package:hungry/views/widgets/modals/register_modal.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(), // Ensure the Container takes up all available space
        child: Stack(
          children: [
            // Background Image with Blur Effect
            Positioned.fill(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 3.0, // Adjust the blur intensity horizontally
                  sigmaY: 3.0, // Adjust the blur intensity vertically
                ),
                child: Image.asset(
                  'assets/images/PackagedFoods2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Foreground Content
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 70 / 100,
                decoration: BoxDecoration(
                  gradient: AppColor.linearBlackBottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo Image
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Image.asset(
                            'assets/images/BetterBitesLogo.png', // Replace with your logo image path
                            height: 300, // Adjust the height as needed
                          ),
                        ),
                        Text(
                          "Scan, Learn, Eat Better",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.5), // Adjust the shadow color
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Buttons and Other Content
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Get Started Button
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: ElevatedButton(
                            child: Text(
                              "Don't have an account? Join Us",
                              style: TextStyle(
                                color: AppColor.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter',
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return RegisterModal();
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: AppColor.primarySoft,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Log in Button
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: OutlinedButton(
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                color: AppColor.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter',
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return LoginModal();
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                color: AppColor.secondary,
                                width: 1,
                              ),
                              primary: Colors.white,
                            ),
                          ),
                        ),
                        // Terms and Privacy Policy Text
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          margin: EdgeInsets.only(top: 32),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'By joining BetterBites, you agree to our ',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms of service ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                  ),
                                ),
                                TextSpan(
                                  text: 'and ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    height: 1.5,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy policy.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
