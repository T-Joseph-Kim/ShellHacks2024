import 'package:flutter/material.dart';
import 'package:hungry/views/utils/AppColor.dart';

class UserInfoTile extends StatelessWidget {
  final String label, value;
  final EdgeInsetsGeometry? margin, padding;
  final Color? valueBackground;
  UserInfoTile({required this.label, required this.value, this.padding, this.margin, this.valueBackground});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('$label', style: TextStyle(color: AppColor.primary, fontSize: 12)),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            color: valueBackground ?? AppColor.primaryExtraSoft,
            child: Text('$value', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'inter')),
          )
        ],
      ),
    );
  }
}

class UserInfoChips extends StatelessWidget {
  final String label;
  final List<String> values;
  final EdgeInsetsGeometry? margin, padding;
  final Color? valueBackground;
  UserInfoChips({required this.label, required this.values, this.padding, this.margin, this.valueBackground});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('$label', style: TextStyle(color: AppColor.primary, fontSize: 12)),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            color: valueBackground ?? AppColor.primaryExtraSoft,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: values.map((value) {
                return Chip(
                  label: Text(value, style: TextStyle(fontSize: 14)),
                  backgroundColor: AppColor.secondary,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColor.primary2,
        elevation: 0,
        centerTitle: true,
        title: Text('My Profile', style: TextStyle(fontFamily: 'inter', fontWeight: FontWeight.w400, fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: TextButton.styleFrom(primary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1 - Profile Picture Wrapper
          Container(
            color: Color.fromARGB(255, 7, 77, 50),
            padding: EdgeInsets.symmetric(vertical: 24),
            child: GestureDetector(
              onTap: () {
                print('Code to open file manager');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                      // Profile Picture
                      image: DecorationImage(image: AssetImage('assets/images/ProfilePicture.jpg'), fit: BoxFit.cover),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Change Profile Picture', style: TextStyle(fontFamily: 'inter', fontWeight: FontWeight.w600, color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.camera_alt, color: Colors.white), // Replaced the camera icon with a simple icon
                    ],
                  )
                ],
              ),
            ),
          ),
          // Section 2 - User Info Wrapper
          Container(
            margin: EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Email',
                  value: 'tjosephkim@gmail.com',
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Full Name',
                  value: 'Taebok Joseph Kim',
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Height',
                  value: '5\' 11"',
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Weight',
                  value: '140 lbs',
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Ethnicity',
                  value: 'East Asian',
                ),
                UserInfoChips(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Allergies',
                  values: ['Peanuts', 'Dairy', 'Gluten'],
                  valueBackground: AppColor.primaryExtraSoft,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
