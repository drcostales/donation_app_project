//this page is what a donor should see upon signing in
//this page should show a list of organizations
//donors can click an organization to donate (show the donation form)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});
  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
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
            child: const Text("this is a donor's home page.")));
  }
}
