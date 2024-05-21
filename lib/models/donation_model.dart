//add method to convert this into a Map <String, dynamic> format. 

class Donation {
  final String category;
  final String pickupOrDropOff;
  final double weight;
  final String? photo;
  final DateTime? dateTime;
  final List<String> address;
  final String contactNumber;
  final String status;
  final String organization;
  final String donor_id;
  
  Donation({
    required this.category,
    required this.pickupOrDropOff,
    required this.weight,
    this.photo,
    this.dateTime,
    required this.address,
    required this.contactNumber,
    required this.status,
    required this.organization,
    required this.donor_id,
  });
}

