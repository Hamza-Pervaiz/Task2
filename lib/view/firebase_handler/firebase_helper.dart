import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // Login function
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "An error occurred during login.";
    }
    return null;
  }

  // Registration function
  Future<User?> signupUser(String email, String password, String name) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': name,
        'email': email,
        'uid': userCredential.user?.uid,
        "password": password
      });

      return userCredential.user;
    } catch (e) {
      print('Signup error: $e');
      throw e; // Rethrow the error for the UI to handle
    }
  }

  // Send email verification
  Future<void> sendVerificationEmail() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Check email verification status
  bool isEmailVerified(User user) {
    return user.emailVerified;
  }

  // Logout
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  Future<bool> updateUser(String uid, Map<String, dynamic> updatedData) async {
    try {
      // Update user data in Firestore
      await _firestore.collection('users').doc(uid).update(updatedData);
      return true;
    } catch (e) {
      print('Error updating user data: $e');
      throw e; // Rethrow the error for the UI to handle
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Initiate Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the login
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user already exists in Firestore, if not, save them
      final User? user = userCredential.user;
      if (user != null) {
        // Check if user is already in Firestore
        var userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (!userDoc.exists) {
          // Save new user data to Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'email': user.email,
            'uid': user.uid,
            'photoURL': user.photoURL,
          });
        }
      }

      return user;
    } catch (e) {
      print('Google Sign-In error: $e');
      throw e; // Rethrow error to handle in UI
    }
  }

  // Auth State Listener
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
