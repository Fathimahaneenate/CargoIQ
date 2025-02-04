import 'dart:convert';
import 'dart:developer';
import 'package:courier/Screen/courier.dart';
import 'package:courier/Screen/email/otpscreen.dart';
import 'package:courier/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../COMMONVIEWMODEL/commonviewmodel.dart';

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  bool isAccepted = false;

  CommonViewModel? vm;

  // Save data to SharedPreferences
  Future<void> saveUserDetails(
      String firstName, String lastName, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Your Profile",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Track your packages and much more.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: "First name",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last name",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "you@example.com",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    } else if (value == "a@gmail.com" ||
                        value == "example@example.com" ||
                        value == "test@test.com") {
                      return 'Please enter a valid, real email address';
                    }

                    return null;
                  },
                ),
                SizedBox(height: bottomInset > 0 ? 30 : 200),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),
                    children: [
                      TextSpan(text: "Our "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                          text:
                              " outlines what personal data we collect, why we collect it, and how we use it. Our "),
                      TextSpan(
                        text: "Conditions of Use",
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                          text:
                              " govern your access and use of this application."),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.black,
                      value: isAccepted,
                      onChanged: (value) {
                        setState(() {
                          isAccepted = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "I have read and I accept the Privacy Policy and Conditions of Use",
                          style: TextStyle(fontSize: 13.5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: bottomInset > 0 ? 20 : 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAccepted
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              vm = Provider.of<CommonViewModel>(context,
                                  listen: false);
                            bool success = await  vm!.registration(
                                  firstNameController.text,
                                  lastNameController.text,
                                  emailController.text);

                              if (success) {
                                await saveUserDetails(
                                  firstNameController.text,
                                  lastNameController.text,
                                  emailController.text,
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration failed. Try again!")));
                              }
                              setState(() {
                                isLoading = false;
                              });
                              // .then((value) => Navigator.push(context,
                              //         MaterialPageRoute(builder: (context) {
                              //       return MyHomePage();
                              //     })));

                              // await saveUserDetails(
                              //   firstNameController.text,
                              //   lastNameController.text,
                              //   emailController.text,
                              // );
                              // await _saveUserData();

                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => MyHomePage()),
                              // );
                              // registration(
                              //   firstNameController.text,
                              //   lastNameController.text,
                              //   emailController.text,
                              // );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isAccepted ? Color(0xfff071e30) : Colors.grey[400],
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                    ? CircularProgressIndicator(color: Colors.white,)
                    : Text(
                      "Create Your Account",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
