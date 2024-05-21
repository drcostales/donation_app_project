//this page should show a list of donations intended for the logged in organization. 
//clicking a donation should show the donation's details
//the logged in organization must be able to change the status of the donation <pending, confirmed, scheduled for pick-up, completed, canceled> 
//save button to finalize ? 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class OrgHomePage extends StatefulWidget {
  const OrgHomePage({super.key});
  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

class _OrgHomePageState extends State<OrgHomePage> {
  // User? user;//would need to change this
  Stream<Map<String, String>>? _userDetailsStream;
  Map<String, String>? _userDetails;

  @override
  void initState() {
    super.initState();
    _userDetailsStream = context.read<UserAuthProvider>().currentUserInfo();
    _userDetailsStream!.listen((userDetails) {
      setState(() {
        _userDetails = userDetails;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
        body: Container(
          margin: const EdgeInsets.all(30),
          child: const Text("this is an organization's home page.")
        ));
  }
}
