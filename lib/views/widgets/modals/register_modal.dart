import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _heightInchesController = TextEditingController();

  // Selected values for dropdowns
  String? _selectedEthnicity;
  List<String> _selectedAllergies = [];

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
          height: MediaQuery.of(context).size.height * 85 / 100,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
          decoration: BoxDecoration(
            color: AppColor.primarySoft,
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
          SizedBox(height: 20),
          CustomTextField(title: 'Email', hint: 'e.g. foodlover@email.com', controller: _emailController),
          CustomTextField(title: 'Full Name', hint: 'Your Full Name', margin: EdgeInsets.only(top: 16), controller: _fullNameController),
          CustomTextField(title: 'Password', hint: '**********', obsecureText: true, margin: EdgeInsets.only(top: 16), controller: _passwordController),
          CustomTextField(title: 'Retype Password', hint: '**********', obsecureText: true, margin: EdgeInsets.only(top: 16), controller: _retypePasswordController),
          SizedBox(height: 30),
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
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    style: TextStyle(
                      color: AppColor.primary,
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

  // Weight and Height Input Page
  Widget _buildWeightHeightPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter your Body Weight and Height',
            style: TextStyle(color: AppColor.secondary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'inter'),
          ),
          SizedBox(height: 20),
          CustomTextField(
            title: 'Weight (lbs)',
            hint: 'e.g. 150',
            controller: _weightController,
          ),
          SizedBox(height: 20),
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
            'Select your Ethnicity and Allergies',
            textAlign: TextAlign.center, // Center-align the title
            style: TextStyle(
              color: AppColor.secondary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'inter',
            ),
          ),
          SizedBox(height: 20),
          // Styled DropdownButtonFormField for ethnicity
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
              labelText: 'Ethnicity',
              labelStyle: TextStyle(
                color: AppColor.primary, // Label color
                fontFamily: 'inter',
                fontWeight: FontWeight.bold
              ),
              filled: true,
              fillColor: AppColor.secondary, // Background color of the dropdown
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primary), // Border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primary, width: 2),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _selectedEthnicity = value;
              });
            },
            icon: Icon(Icons.arrow_drop_down, color: AppColor.primary), // Dropdown icon color
          ),
          SizedBox(height: 20),
          // Styled Wrap for allergies
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
          title: Text('Summary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${_emailController.text}'),
              Text('Name: ${_fullNameController.text}'),
              Text('Weight: ${_weightController.text} lbs'),
              Text('Height: ${_heightFeetController.text}\' ${_heightInchesController.text}"'),
              Text('Ethnicity: ${_selectedEthnicity ?? 'Not selected'}'),
              Text('Allergies: ${_selectedAllergies.isNotEmpty ? _selectedAllergies.join(', ') : 'None'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSwitcher()));
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
