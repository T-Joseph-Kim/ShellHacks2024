import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hungry/views/screens/page_switcher.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:hungry/views/widgets/custom_text_field.dart';
import 'package:hungry/views/widgets/modals/login_modal.dart';

class RegisterModal extends StatefulWidget {
  @override
  _RegisterModalState createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  // Controllers for registration form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();

  // Controllers for carousel fields
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightFeetController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightInchesController = TextEditingController();

  // Selected values for dropdowns
  String? _selectedEthnicity;
  String? _selectedSex; // Dropdown value for sex
  List<String> _selectedAllergies = [];

  // Sex options
  final List<String> _sexOptions = ['Male', 'Female'];

  // Ethnicity and allergies options
  final List<String> _ethnicityOptions = [
    'East Asian', 'South Asian', 'Southeast Asian', 'Pacific Islander', 'African', 
    'African American', 'Hispanic/Latino', 'Middle Eastern/North African', 
    'Native American/Indigenous', 'White/Caucasian', 'Other'
  ];
  
  final List<String> _allergyOptions = [
    'Peanuts', 'Tree Nuts', 'Shellfish', 'Dairy', 'Eggs', 
    'Fish', 'Soy', 'Corn', 'Sesame', 'Wheat/Gluten', 'None'
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 84 / 100,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 7, 77, 50),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // White bar at the top similar to LoginModal
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  margin: EdgeInsets.only(bottom: 20),
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // The color of the bar
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Expanded(
                child: CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: double.infinity,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: [
                    _buildRegistrationForm(),
                    _buildWeightHeightPage(),
                    _buildEthnicityAllergyPage(),
                  ],
                ),
              ),
              _buildCarouselIndicators(),
            ],
          ),
        ),
      ],
    );
  }

  // Carousel indicators
  Widget _buildCarouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? AppColor.secondary : Colors.grey,
          ),
        );
      }),
    );
  }

  // Registration form
  Widget _buildRegistrationForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Join Us',
            style: TextStyle(color: AppColor.secondary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'inter'),
          ),
          SizedBox(height: 15),
          CustomTextField(title: 'Email', hint: 'e.g. foodlover@email.com', controller: _emailController),
          CustomTextField(title: 'Full Name', hint: 'Your Full Name', margin: EdgeInsets.only(top: 16), controller: _fullNameController),
          CustomTextField(title: 'Password', hint: '**********', obsecureText: true, margin: EdgeInsets.only(top: 16), controller: _passwordController),
          CustomTextField(title: 'Retype Password', hint: '**********', obsecureText: true, margin: EdgeInsets.only(top: 16), controller: _retypePasswordController),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                isScrollControlled: true,
                builder: (context) {
                  return LoginModal();
                },
              );
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            child: RichText(
              text: TextSpan(
                text: 'Have an account? ',
                style: TextStyle(color: AppColor.secondary, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'inter',
                    ),
                    text: 'Log in',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Weight and Height Input Page with Sex Dropdown
  Widget _buildWeightHeightPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tell Us About Yourself',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.secondary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'inter'),
          ),
          SizedBox(height: 15),
          // Weight and Age Input Row
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  title: 'Weight (lbs)',
                  hint: 'e.g. 150',
                  controller: _weightController,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CustomTextField(
                  title: 'Age',
                  hint: 'e.g. 42',
                  controller: _ageController,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Height Input Row
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  title: 'Height (feet)',
                  hint: 'e.g. 5',
                  controller: _heightFeetController,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CustomTextField(
                  title: 'Height (inches)',
                  hint: 'e.g. 11',
                  controller: _heightInchesController,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Sex Dropdown Row
          Text(
            '  Sex',
            style: TextStyle(color: AppColor.secondary, fontSize: 14, fontFamily: 'inter'),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedSex,
                  items: _sexOptions.map((sex) {
                    return DropdownMenuItem(
                      value: sex,
                      child: Text(
                        sex,
                        style: TextStyle(
                          color: AppColor.primary,
                          fontFamily: 'inter',
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'e.g. Female',
                    labelStyle: TextStyle(fontSize: 14, color: Color.fromARGB(255, 50, 50, 50).withOpacity(0.6)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedSex = value;
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down, color: AppColor.primary),
                  dropdownColor: Colors.white, // Background color for the dropdown menu
                  // Styling the dropdown menu items
                  style: TextStyle(
                    color: AppColor.primary,
                    fontFamily: 'inter',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Ethnicity and Allergies Selection Page
  Widget _buildEthnicityAllergyPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch, // Make content stretch horizontally
        children: [
          Text(
            'Tell Us About Yourself',
            textAlign: TextAlign.center, // Center-align the title
            style: TextStyle(color: AppColor.secondary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'inter'),
          ),
          SizedBox(height: 15),
          // Styled DropdownButtonFormField for ethnicity
          Text(
            '  Ethnicity',
            style: TextStyle(color: AppColor.secondary, fontSize: 14, fontFamily: 'inter'),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedEthnicity,
            items: _ethnicityOptions.map((ethnicity) {
              return DropdownMenuItem(
                value: ethnicity,
                child: Text(
                  ethnicity,
                  style: TextStyle(
                    color: AppColor.primary, // Adjust text color
                    fontFamily: 'inter',
                  ),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'e.g. East Asian',
              labelStyle: TextStyle(fontSize: 14, color: Color.fromARGB(255, 50, 50, 50).withOpacity(0.6)),
              filled: true,
              fillColor: Colors.white, // Background color of the dropdown
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
                borderSide: BorderSide(color: AppColor.primary), // Border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
                borderSide: BorderSide(color: AppColor.primary),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _selectedEthnicity = value;
              });
            },
            icon: Icon(Icons.arrow_drop_down, color: AppColor.primary), // Dropdown icon color
            dropdownColor: Colors.white, // Background color for the dropdown menu
            // Styling the dropdown menu items
            style: TextStyle(
              color: AppColor.primary,
              fontFamily: 'inter',
            ),
          ),
          SizedBox(height: 20),
          // Styled Wrap for allergies
          Text(
            '  Do You Have Food Allergies?',
            style: TextStyle(color: AppColor.secondary, fontSize: 15, fontFamily: 'inter'),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4, // Adjust vertical spacing between chips
            children: _allergyOptions.map((allergy) {
              return ChoiceChip(
                label: Text(
                  allergy,
                  style: TextStyle(
                    color: _selectedAllergies.contains(allergy)
                        ? AppColor.secondary // Selected chip text color
                        : AppColor.primary, // Unselected chip text color
                    fontFamily: 'inter',
                  ),
                ),
                selected: _selectedAllergies.contains(allergy),
                selectedColor: AppColor.primary, // Background color when selected
                backgroundColor: Colors.grey[200], // Background color when not selected
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: _selectedAllergies.contains(allergy)
                        ? AppColor.primary
                        : Colors.grey[400]!, // Border color
                  ),
                ),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedAllergies.add(allergy);
                    } else {
                      _selectedAllergies.remove(allergy);
                    }
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Submit Button
          ElevatedButton(
            onPressed: _showSummaryDialog,
            child: Text(
              'Submit',
              style: TextStyle(
                color: AppColor.primary,
                fontFamily: 'inter',
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: AppColor.secondary,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show a dialog with the input summary
  void _showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 242, 242, 242), // Light background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          title: Text(
            'Summary',
            style: TextStyle(
              fontFamily: 'inter',
              fontWeight: FontWeight.bold,
              color: AppColor.primary, // Primary color for title text
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryRow('Email:', _emailController.text),
              _buildSummaryRow('Name:', _fullNameController.text),
              _buildSummaryRow('Weight:', '${_weightController.text} lbs'),
              _buildSummaryRow('Height:', '${_heightFeetController.text}\' ${_heightInchesController.text}"'),
              _buildSummaryRow('Sex:', _selectedSex ?? 'Not selected'),
              _buildSummaryRow('Ethnicity:', _selectedEthnicity ?? 'Not selected'),
              _buildSummaryRow('Allergies:', _selectedAllergies.isNotEmpty ? _selectedAllergies.join(', ') : 'None'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: AppColor.primary, // Secondary color for buttons
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _saveDataAndNavigate();
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  color: AppColor.primary2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper method for building summary rows
  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.bold,
            color: AppColor.primarySoft, // Secondary color for labels
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.normal,
                color: AppColor.primarySoft, // Default color for values
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Save data to local storage and navigate to next page
  Future<void> _saveDataAndNavigate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('email', _emailController.text);
      await prefs.setString('name', _fullNameController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setString('age', _ageController.text);
      await prefs.setString('weight', _weightController.text);
      await prefs.setString('heightFeet', _heightFeetController.text);
      await prefs.setString('heightInches', _heightInchesController.text);
      await prefs.setString('sex', _selectedSex ?? '');
      await prefs.setString('ethnicity', _selectedEthnicity ?? '');
      await prefs.setStringList('allergies', _selectedAllergies);

      // Close the summary dialog and navigate to the next page
      Navigator.pop(context); // This will close the dialog
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSwitcher()));
    } catch (e) {
      print('Error saving data: $e');
      // Optionally show error message or handle error case here
    }
  }

}
