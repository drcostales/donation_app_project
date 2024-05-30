import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:phonenumbers/phonenumbers.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();
  String? fname;
  String? lname;
  String? address;
  String? contact;
  String? email;
  String? password;
  bool isPasswordValid = false;

  final _pwcontroller = TextEditingController();

  @override
  void dispose() {
    _pwcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading,
                  fnameField,
                  lnameField,
                  contactField,
                  addressField,
                  emailField,
                  passwordField,
                  submitButton
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  Widget get fnameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("First Name"),
              hintText: "Enter your first name"),
          onSaved: (value) => setState(() => fname = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your first name";
            }
            return null;
          },
        ),
      );

  Widget get lnameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Last Name"),
              hintText: "Enter your last name"),
          onSaved: (value) => setState(() => lname = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your last name";
            }
            return null;
          },
        ),
      );

  Widget get contactField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          // controller: _contactController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Contact Number"),
              hintText: "Enter your contact number"),
          onSaved: (value) => setState(() => contact = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your contact";
            }
            return null;
          },
        ),
      );

  Widget get addressField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Address"),
              hintText: "Enter your address"),
          onSaved: (value) => setState(() => address = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your address";
            }
            return null;
          },
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Email"),
              hintText: "Enter a valid email"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid email format";
            }
            if (!EmailValidator.validate(value)) {
              return "Please enter a valid email address (e.g. juandelacruz@gmail.com)";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    controller: _pwcontroller,
                    obscureText: true, // Hide password
                    decoration: const InputDecoration(
                        label: Text("Password"),
                        hintText: "Enter your password",
                        border: OutlineInputBorder()),
                    onSaved: (value) => setState(() => password = value),
                    validator: (value) {
                      if (!isPasswordValid) {
                        return "Please enter a valid password";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 4),
                FlutterPwValidator(
                  key: validatorKey,
                  controller: _pwcontroller,
                  minLength: 6,
                  uppercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  width: 400,
                  height: 140,
                  onSuccess: () {
                    setState(() {
                      isPasswordValid = true; // Update password validity state
                    });
                    print("Password is valid");
                  },
                  onFail: () {
                    setState(() {
                      isPasswordValid = false; // Update password validity state
                    });
                    print("Password is not valid");
                  },
                )
              ],
            ),
          )
        ],
      );

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          String fullname = "${fname!} ${lname!}";
          Map<String, dynamic> userData = {
            "full name": fullname,
            "contact": contact,
            "address": address
          };
          await context
              .read<UserAuthProvider>()
              .authService
              .signUp(true, email!, password!, userData);

          // check if the widget hasn't been disposed of after an asynchronous action
          if (mounted) Navigator.pop(context);
        }
      },
      child: const Text("Sign Up"));
}
