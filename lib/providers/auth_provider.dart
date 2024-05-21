import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/firebase_auth_api.dart';

//added a getUID method

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService; //eto baga yung authservice naten
  late Stream<User?> _uStream;
  late Stream<Map<String, String>> _usermap;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User? get user => authService.getUser();

  void fetchAuthentication() {
    _uStream = authService.userSignedIn();

    notifyListeners();
  }

  Future<void> signUp(bool donor, String email, String password, Map<String, dynamic> userMap ) async {
    await authService.signUp(donor, email, password, userMap);
    //create map here -- probably should create map in the submit button INSTEAD so this function only takes a Map<String, dynamic> instead of maybe taking a Donor Model or an Org Model. 
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    // this returns "Org" if the signed in user is from an org, and "Donor" if the current user is a donor. 
    String? message = await authService.signIn(email, password);
    notifyListeners();

    return message; 
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }

  String getUid() {
    // Check if the user is authenticated before accessing the UID
    if (authService.getUser() != null) {
      return authService.getUser()!.uid;
    } else {
      // Handle the case where the user is not authenticated
      return '';
    }
  }

  // void fetchUserDetails() {
  //   _usermap = authService.getUserInfo().asBroadcastStream();
  //   notifyListeners();
  // }
  Stream<Map<String, String>> currentUserInfo(){
    _usermap = authService.getUserInfo().asBroadcastStream();
    notifyListeners();
    return _usermap;
  }

}
