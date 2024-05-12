import 'package:flutter/material.dart';

class OrgList extends StatefulWidget {
  const OrgList({Key? key}) : super(key: key);

  @override
  State<OrgList> createState() => _OrgListState();
}

class _OrgListState extends State<OrgList> {
  final List<Map<String, String>> organizations = [
    {"name": "Care for Gaza", "description": "Aid for Gaza residents"},
    {
      "name": "Project Zero K",
      "description": "Environmental conservation initiative"
    },
    {
      "name": "Strays Worth Saving (SWS)",
      "description": "Animal rescue and welfare organization"
    },
    {
      "name": "Bach Project",
      "description": "Promoting classical music education"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Organizations",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: organizations.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                organizations[index]["name"]!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                organizations[index]["description"]!,
                style: const TextStyle(fontSize: 12),
              ),
              trailing: TextButton(
                onPressed: () {
                  // Navigate to details page or perform action on button press
                },
                child: const Text("View Details"),
              ),
            ),
          );
        },
      ),
    );
  }
}
