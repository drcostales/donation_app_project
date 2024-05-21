//This page contains the form where for donors can submit a donation
//optional submit an image of their donation <box of clothes, grocery packs, etc> 
// a donation can be canceled by the organization 
/** MGA KULANG PA
 * - enter donation pick up address string na lang
 * - upload photo option
 */

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationForm extends StatefulWidget {
  final String organization_id; 

  const DonationForm({Key? key, required this.organization_id}) : super(key: key);

  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  final _formKey = GlobalKey<FormState>();
  String _category = "Food";
  String? _pickupOrDropOff = 'Pickup';
  TextEditingController _weightController = TextEditingController();
  TextEditingController _photoController = TextEditingController();
  DateTime? _dateTime;
  TimeOfDay? _time;
  // LatLng _selectedLocation = LatLng(0, 0);
  TextEditingController _contactNumberController = TextEditingController();
  String donor_id = "011";
  String _status = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Form for ${widget.organization_id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Donation Category"),
              CategoryDropdown(
                onChanged: (String value) {
                  _category = value;
                },
              ),
              PickupDropOffRadio(
                onChanged: (value) {
                  setState(() {
                    _pickupOrDropOff = value;
                  });
                },
              ),
              CustomTextField((p0) => null, fieldType: 'Weight', controller: _weightController),
              // MapSelectionWidget(onLocationSelected: (value){_selectedLocation = value;}),
 
              const Text("Schedule Pickup or Dropoff"),
              DateTimePicker(onDateTimeChanged: (dateTime){
                _dateTime = dateTime;
              }),
              CustomTextField((p0) => null, fieldType: 'phone number', controller: _contactNumberController)
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////
class CategoryDropdown extends StatefulWidget {
  final Function(String) onChanged;

  const CategoryDropdown({Key? key, required this.onChanged}) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String _selectedCategory = 'Food';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: _selectedCategory,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedCategory = newValue;
            widget.onChanged(newValue);
          });
        }
      },
      items: <String>['Food', 'Clothes', 'Cash', 'Necessities', 'Others']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class PickupDropOffRadio extends StatefulWidget {
  final Function(String?) onChanged;
  PickupDropOffRadio({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<PickupDropOffRadio> createState() => _PickupDropOffRadioState();
}

class _PickupDropOffRadioState extends State<PickupDropOffRadio> {
   String _selectedOption = 'Pickup';

  final Map<String, bool> radioOptions = {
    'Pickup': true,
    'Dropoff': false,
  };
  
    @override
  Widget build(BuildContext context) {
    return Column( //Column of Motto text title and column of radio options
              children: [ 
                const Text('Pickup/Dropoff:', 
                    // style: TextStyle(fontSize: 30), 
                    textAlign:TextAlign.left,),
                Column( //Motto options in Radio List Tiles
                  children: radioOptions.keys.map((_selectedOption) {
                    return RadioListTile<String>(
                      title: Text(_selectedOption, style: const TextStyle(fontSize: 20),),
                      value: _selectedOption,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                        widget.onChanged.call(_selectedOption);
                      },
                    );
                  }).toList(), 
                ),
              ],
            );
  }
}

class CustomTextField extends StatefulWidget {
  final Function(String) callback;
  // final Function() onReset;
  final String fieldType;
  final TextEditingController controller;

  const CustomTextField(
    this.callback, {
    required this.fieldType,
    // required this.onReset,
    required this.controller,
    Key? key,
  }) : super(key: key);

 
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.fieldType,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the ${widget.fieldType.toLowerCase()}';
          }
          if (widget.fieldType == 'Weight in kg') {
            try {
              double.parse(value);
            } catch (e) {
              return 'Please enter a valid weight number';
            }
          }
          if (widget.fieldType == 'phone number') {
              RegExp r = RegExp(r'^\d{11}$');
              if (!r.hasMatch(value)) {
                return 'Please enter a valid phone number';
              }

          }
          return null;
        },
        onChanged: (value) {
          widget.callback(value); // Pass the value directly
          
        },
        keyboardType:
            widget.fieldType == 'Age' ? TextInputType.number : null,
      ),
    );
  }
}

class DateTimePicker extends StatefulWidget {
  final Function(DateTime) onDateTimeChanged;

  const DateTimePicker({Key? key, required this.onDateTimeChanged}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: 
            [TextButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            Text('Selected Date: ${_selectedDate.toString().substring(0, 10)}'),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select Time'),
            ),
            Text('Selected Time: ${_selectedTime.format(context)}'),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateTimeChanged(DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ));
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        widget.onDateTimeChanged(DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          picked.hour,
          picked.minute,
        ));
      });
    }
  }
}

// class MapSelectionWidget extends StatefulWidget {
//   final void Function(LatLng) onLocationSelected;

//   const MapSelectionWidget({Key? key, required this.onLocationSelected}) : super(key: key);

//   @override
//   _MapSelectionWidgetState createState() => _MapSelectionWidgetState();
// }

// class _MapSelectionWidgetState extends State<MapSelectionWidget> {
//   late GoogleMapController mapController;
//   LatLng _selectedLocation = LatLng(0, 0);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 300,
//           child: GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//             initialCameraPosition: CameraPosition(
//               target: LatLng(0, 0), // Initial map center
//               zoom: 15, // Initial zoom level
//             ),
//             onTap: (LatLng location) {
//               setState(() {
//                 _selectedLocation = location;
//                 widget.onLocationSelected(_selectedLocation); // Notify parent widget
//               });
//             },
//           ),
//         ),
//         SizedBox(height: 20),
//         Text('Selected Location: ${_selectedLocation.latitude}, ${_selectedLocation.longitude}'),
//       ],
//     );
//   }
// }