// import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names

class Donor {
  String? id; // generated by the firebase auth so ...
  String name;
  String email;
  String contact_no;
  List<String> addresses = [];

  Donor(
    String address, {
    this.id,
    required this.name,
    required this.email,
    required this.contact_no,
    List<String>? addresses,
  }) : addresses = addresses ?? [address];
}
