import 'package:flutter/material.dart';

class OrgList extends StatefulWidget {
  const OrgList({Key? key}) : super(key: key);

  @override
  State<OrgList> createState() => _OrgListState();
}

class _OrgListState extends State<OrgList> {
  final List<Map<String, String>> organizations = [
    {
      "name": "Care for Gaza",
      "description": "Aid for Gaza residents",
      "image": "sampleimages/careforgaza.jpeg"
    },
    {
      "name": "Project Zero K",
      "description": "Aims to save impounded dogs",
      "image": "sampleimages/sws.jpeg"
    },
    {
      "name": "Strays Worth Saving (SWS)",
      "description": "Animal rescue and welfare organization"
    },
    {
      "name": "Bach Project",
      "description": "Animal rescue and welfare organization",
      "image": "sampleimages/sws.jpeg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizations"),
      ),
      body: ListView.builder(
        itemCount: organizations.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (organizations[index]["image"] != null)
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.asset(
                      organizations[index]["image"]!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ListTile(
                  title: Text(
                    organizations[index]["name"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    organizations[index]["description"]!,
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // navigate to donation form page
                    },
                    child: const Text("View Org"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
