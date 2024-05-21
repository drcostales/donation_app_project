//firstname field
//lastname field
//password requirements regex




import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]{1,30}$');

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
                children: [heading, firstNameField, lastNameField, emailField, passwordField, submitButton],
              ),
            )),
      ),
    );
  }

  Widget get firstNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("First Name"),
              ),
          onSaved: (value) => setState(() => firstname = value),
          validator: (value) {
            if (!nameRegExp.hasMatch(value ?? "")) {
              return "Enter your first name.";
            }return null;
          },
        ),
      );

  Widget get lastNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Last Name"),
              ),
          onSaved: (value) => setState(() => lastname = value),
          validator: (value) {
            if (!nameRegExp.hasMatch(value ?? "")) {
              return "Enter your last name.";
            }return null;
          },
        ),
      );

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
            RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
            if (value == null || value.isEmpty) {
              return "Please enter a valid email format.";
            } else if (!emailRegExp.hasMatch(value)) {
              return "Please enter a valid email format.";
            }return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(children: [TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Password"),
              hintText: "At least 6 characters"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid password";
            }
            //Using regexp to force user to make a secure password
            //(?=.*[\W_]) uses non-word characters 
            final RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,}$');
            if (!passwordRegex.hasMatch(value)) {
              return  "Password must have at least 1 small letter, 1 capital  \nletter, 1 digit, 1 special character, and at least 8 \ncharacters";
            }
            return null;
          },
        ),const SizedBox(height: 8,)],)
      );

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        // if (_formKey.currentState!.validate()) {
        //   _formKey.currentState!.save();
        //   await context
        //       .read<UserAuthProvider>()
        //       .authService
        //       .signUp(bool donor, lastname!, email!, password!);

        //   // check if the widget hasn't been disposed of after an asynchronous action
        //   if (mounted) Navigator.pop(context);

        //   // Navigate to home page if sign up is successful
        //   Navigator.pushReplacementNamed(context, '/home');

        // }
      },
      child: const Text("Sign Up"));
}
