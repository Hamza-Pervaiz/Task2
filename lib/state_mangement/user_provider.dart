import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_nextpak/state_mangement/offline_user.dart';
import 'package:task_nextpak/view/firebase_handler/firebase_helper.dart';

class AuthProvider extends ChangeNotifier {
  bool _isOffline = false;

  bool get isOffline => _isOffline;

  // Method to check internet connectivity
  Future<void> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    _isOffline = connectivityResult == ConnectivityResult.none;
    notifyListeners();
  }

  // Offline login using SharedPreferences
  Future<OfflineUser?> offlineLogin(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    final storedPassword = prefs.getString('password');

    if (storedUsername == username && storedPassword == password) {
      // Mock User object for offline login (replace with actual logic)
      return OfflineUser(uid: 'offline-user-id', email: username);
    } else {
      return null; // Invalid credentials
    }
  }

  // Method for online login via Firebase
  Future<User?> loginUser(String username, String password) async {
    return await FirebaseAuthService().loginUser(username, password);
  }
}
