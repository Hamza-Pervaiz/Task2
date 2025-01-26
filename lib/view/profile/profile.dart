import 'package:flutter/material.dart';
import 'package:task_nextpak/assets/sizes/size.dart';
import 'package:task_nextpak/view/auth/sign_in_screen.dart';
import 'package:task_nextpak/view/firebase_handler/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> fetchUserData() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        if (userDoc.exists) {
          var data = userDoc.data() as Map<String, dynamic>;
          setState(() {
            namecon.text = data['username'] ?? '';
            emailcon.text = data['email'] ?? '';
            passwordCon.text = data['password'] ?? '';
            // Do not expose the password directly for security reasons
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  final _formKey = GlobalKey<FormState>();

  var namecon = TextEditingController();
  var emailcon = TextEditingController();
  var passwordCon = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  bool _passwordVisible = false;
  Color btncolor = const Color.fromARGB(255, 94, 92, 92);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset(
            'lib/assets/images/bg_image.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: responsive.screenWidth * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //   color: Colors.red,
                    height: responsive.screenWidth * 0.6,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: responsive.screenWidth * 0.03),
                    child: Image.asset(
                      'lib/assets/images/sign_up_ilustration.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: responsive.screenHeight * 0.70,
                    padding: EdgeInsets.all(responsive.screenWidth * 0.05),
                    margin: EdgeInsets.only(top: responsive.screenWidth * 0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(146, 63, 62, 63),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(responsive.screenWidth * 0.12),
                        topRight:
                            Radius.circular(responsive.screenWidth * 0.12),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: responsive.screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'you can update your profile',
                            style: TextStyle(
                              fontSize: responsive.screenWidth * 0.03,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: responsive.screenWidth * 0.03),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'username',
                              style: TextStyle(
                                fontSize: responsive.screenWidth * 0.05,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: responsive.screenWidth * 0.01),
                          TextFormField(
                            controller: namecon,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }

                              return null; // No errors
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: btncolor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(responsive.screenWidth *
                                    0.04), // Adjust the padding to your liking
                                child: Image.asset(
                                  color: Colors.white,
                                  'lib/assets/images/name_icon.png', // Path to your prefix image
                                  width: responsive.screenWidth *
                                      0.04, // Size of the prefix image
                                  height: responsive.screenWidth *
                                      0.04, // Size of the prefix image
                                ),
                              ),
                              hintText: 'username',
                              label: const Text('username'),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: responsive.screenWidth * 0.005),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: responsive.screenWidth * 0.005),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: responsive.screenWidth *
                                    0.03, // Increase the height of the field
                                horizontal: responsive.screenWidth * 0.005,
                              ),
                            ),
                          ),
                          SizedBox(height: responsive.screenWidth * 0.03),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'email',
                              style: TextStyle(
                                fontSize: responsive.screenWidth * 0.05,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: responsive.screenWidth * 0.01),
                          TextFormField(
                            controller: emailcon,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return "Please enter a valid email";
                              }
                              return null; // No errors
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: btncolor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(responsive.screenWidth *
                                    0.04), // Adjust the padding to your liking
                                child: Image.asset(
                                  color: Colors.white,
                                  'lib/assets/images/mail_icon.png', // Path to your prefix image
                                  width: responsive.screenWidth *
                                      0.04, // Size of the prefix image
                                  height: responsive.screenWidth *
                                      0.04, // Size of the prefix image
                                ),
                              ),
                              hintText: 'email',
                              label: const Text('email'),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: responsive.screenWidth * 0.005),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: responsive.screenWidth * 0.005),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: responsive.screenWidth *
                                    0.03, // Increase the height of the field
                                horizontal: responsive.screenWidth * 0.005,
                              ),
                            ),
                          ),
                          SizedBox(height: responsive.screenWidth * 0.03),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'password',
                              style: TextStyle(
                                fontSize: responsive.screenWidth * 0.05,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: responsive.screenWidth * 0.01),
                          TextFormField(
                            controller: passwordCon,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters long";
                              }
                              return null; // No errors
                            },
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: btncolor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(
                                    responsive.screenWidth * 0.04),
                                child: Image.asset(
                                  color: Colors.white,
                                  'lib/assets/images/password_icon.png',
                                  width: responsive.screenWidth * 0.04,
                                  height: responsive.screenWidth * 0.04,
                                ),
                              ),
                              hintText: 'password',
                              labelText: 'password',
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: responsive.screenWidth * 0.005),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: responsive.screenWidth * 0.005),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: responsive.screenWidth * 0.03,
                                horizontal: responsive.screenWidth * 0.005,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: responsive.screenWidth * 0.09),
                          ElevatedButton(
                            onPressed: () async {
                              // Check if all fields are filled
                              if (namecon.text.isEmpty ||
                                  emailcon.text.isEmpty ||
                                  passwordCon.text.isEmpty) {
                                // Show an AlertDialog if fields are empty
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'Please fill in all the fields.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Call the signup function from FirebaseAuthService
                                Map<String, dynamic> m = {
                                  "username": namecon.text,
                                  "email": emailcon.text,
                                  "password": passwordCon.text
                                };

                                bool isupdated = await FirebaseAuthService()
                                    .updateUser(user!.uid, m);
                                if (isupdated) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'User updated Successfully.')));
                                }
                              }
                            },

                            // Show a success message

                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    responsive.screenWidth * 0.05),
                              ),
                              elevation: 0,
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.pink,
                                    Colors.purple
                                  ], // Pink and Purple gradient
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(
                                    responsive.screenWidth *
                                        0.05), // Rounded corners for gradient
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  vertical: responsive.screenWidth *
                                      0.03, // Responsive vertical padding
                                  horizontal: responsive.screenWidth *
                                      0.1, // Responsive horizontal padding
                                ),
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsive.screenWidth *
                                        0.05, // Responsive font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: responsive.screenWidth * 0.01),
                          SizedBox(height: responsive.screenWidth * 0.05),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () async {
                                await FirebaseAuthService().logoutUser();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()),
                                );
                              },
                              child: Text(
                                'logout',
                                style: TextStyle(
                                  fontSize: responsive.screenWidth * 0.03,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
