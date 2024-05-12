import 'package:flutter/material.dart';

class Organization{
  String id;
  String name;
  String description;
  List<Image> images;
  List<Donation> donations;

  Organization({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.donations,
  })
}

class Donation{
  String transactionId;
  String donorId;
  double amount;
  String status;

  Donation({
    required this.transactionId,
    required this.donorId,
    required this.amount,
    required this.status,
  })

}