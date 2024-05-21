// ignore_for_file: non_constant_identifier_names

class Organization {
  String? id;
  String name;
  String username;
  String email;
  String contact_no;
  List<String> addresses = [];
  String details;
  String org_name;
  String status;

  Organization(String address, {
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.contact_no,
    List<String>? addresses,
    required this.details,
    required this.org_name,
    this.status = "Pending",
  }) : addresses = addresses ?? [address];
}