import 'package:flutter/material.dart';
import 'package:task_nextpak/assets/sizes/size.dart';
import 'package:task_nextpak/state_mangement/offline_user.dart';
import 'package:task_nextpak/view/firebase_handler/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_nextpak/view/profile/profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_nextpak/state_mangement/user_provider.dart' as fba;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var namecon = TextEditingController();
  var passwordCon = TextEditingController();
  bool _passwordVisible = false;
  Color btncolor = const Color.fromARGB(255, 94, 92, 92);

  @override
  Widget build(BuildContext context) {
    var authProvider = fba.AuthProviders();
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
                      'lib/assets/images/login_Illustration.png',
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
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: responsive.screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'We missed you!',
                          style: TextStyle(
                            fontSize: responsive.screenWidth * 0.05,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: responsive.screenWidth * 0.1),
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
                                  0.04, // Increase the height of the field
                              horizontal: responsive.screenWidth * 0.005,
                            ),
                          ),
                        ),
                        SizedBox(height: responsive.screenWidth * 0.05),
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
                              padding:
                                  EdgeInsets.all(responsive.screenWidth * 0.04),
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
                              vertical: responsive.screenWidth * 0.04,
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
                        SizedBox(height: responsive.screenWidth * 0.05),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'forget password',
                            style: TextStyle(
                              fontSize: responsive.screenWidth * 0.03,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: responsive.screenWidth * 0.05),
                        ElevatedButton(
// Your login button
                          onPressed: () async {
                            if (namecon.text.isEmpty ||
                                passwordCon.text.isEmpty) {
                              // Show an AlertDialog if fields are empty
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      const Text('Please fill in all fields.'),
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
                              // Check internet connectivity
                              final connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                // If offline, attempt to log in offline

                                try {
                                  OfflineUser? offlineUser =
                                      await authProvider.offlineLogin(
                                          namecon.text.trim(),
                                          passwordCon.text.trim());

                                  if (offlineUser != null) {
                                    // Navigate to the next screen (Offline mode)
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Profile()),
                                    );
                                  } else {
                                    // Show an error if offline login fails
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Login Failed'),
                                        content: const Text(
                                            'Invalid offline credentials. Please try again.'),
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
                                  }
                                } catch (e) {
                                  // Handle any exceptions during the offline login process
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: Text(e.toString()),
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
                                }
                              } else {
                                // If online, attempt to log in using Firebase
                                try {
                                  User? user = await FirebaseAuthService()
                                      .loginUser(namecon.text.trim(),
                                          passwordCon.text.trim());
                                  if (user != null) {
                                    // Navigate to the next screen (Online mode)
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Profile()),
                                    );
                                  } else {
                                    // Show an error if Firebase login fails
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Login Failed'),
                                        content: const Text(
                                            'Invalid credentials. Please try again.'),
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
                                  }
                                } catch (e) {
                                  // Handle any exceptions during the Firebase login process
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: Text(e.toString()),
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
                                }
                              }
                            }
                          },

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
                                    0.04, // Responsive vertical padding
                                horizontal: responsive.screenWidth *
                                    0.1, // Responsive horizontal padding
                              ),
                              child: Text(
                                'Sign In',
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
                        SizedBox(height: responsive.screenWidth * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: btncolor,
                                padding: EdgeInsets.symmetric(
                                  vertical: responsive.screenWidth * 0.01,
                                  horizontal: responsive.screenWidth * 0.01,
                                ),
                              ),
                              onPressed: () {},
                              child: Image.asset(
                                'lib/assets/images/apple_image.png',
                                width: responsive.screenWidth * 0.19,
                                height: responsive.screenWidth * 0.18,
                              ),
                            ),
                            SizedBox(
                              width: responsive.screenWidth * 0.06,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: btncolor,
                                padding: EdgeInsets.symmetric(
                                  vertical: responsive.screenWidth *
                                      0.01, // Adjust vertical padding to your preference
                                  horizontal: responsive.screenWidth *
                                      0.01, // Adjust horizontal padding to your preference
                                ),
                              ),
                              onPressed: () async {
                                User? s = await FirebaseAuthService()
                                    .signInWithGoogle();
                              },
                              child: Image.asset(
                                'lib/assets/images/google_image.png',
                                width: responsive.screenWidth * 0.19,
                                height: responsive.screenWidth * 0.18,
                              ),
                            ),
                            SizedBox(
                              width: responsive.screenWidth * 0.06,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: btncolor,
                                padding: EdgeInsets.symmetric(
                                  vertical: responsive.screenWidth *
                                      0.01, // Adjust vertical padding to your preference
                                  horizontal: responsive.screenWidth *
                                      0.01, // Adjust horizontal padding to your preference
                                ),
                              ),
                              onPressed: () {},
                              child: Image.asset(
                                'lib/assets/images/facebook_image.png',
                                width: responsive.screenWidth * 0.19,
                                height: responsive.screenWidth * 0.18,
                              ),
                            ),
                          ],
                        )
                      ],
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
