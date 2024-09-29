import 'package:flutter/material.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = '';
  String _fullName = '';
  String _age = '';
  String _sex = '';
  String _height = '';
  String _weight = '';
  String _ethnicity = '';
  List<String> _allergies = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? '';
      _fullName = prefs.getString('name') ?? '';
      _age = prefs.getString('age') ?? '';
      _sex = prefs.getString('sex') ?? '';
      String heightFeet = prefs.getString('heightFeet') ?? '0';
      String heightInches = prefs.getString('heightInches') ?? '0';
      _height = '${heightFeet}\' ${heightInches}"';
      _weight = prefs.getString('weight') ?? '';
      _ethnicity = prefs.getString('ethnicity') ?? '';
      _allergies = prefs.getStringList('allergies') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColor.primary2,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(
            color: AppColor.secondary,
            fontFamily: 'inter',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(
                color: AppColor.secondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
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
                      image: DecorationImage(
                        image: AssetImage('assets/images/ProfilePicture.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Change Profile Picture',
                        style: TextStyle(
                          color: AppColor.secondary,
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.camera_alt, color: Colors.white),
                    ],
                  ),
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
                  value: _email,
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Full Name',
                  value: _fullName,
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Age',
                  value: _age,
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Sex',
                  value: _sex,
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Height',
                  value: _height,
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Weight',
                  value: '$_weight lbs',
                ),
                UserInfoTile(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Ethnicity',
                  value: _ethnicity,
                ),
                UserInfoChips(
                  margin: EdgeInsets.only(bottom: 16),
                  label: 'Allergies',
                  values: _allergies,
                  valueBackground: AppColor.primaryExtraSoft,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
