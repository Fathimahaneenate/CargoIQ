

import 'dart:convert';
import 'package:courier/COMMONVIEWMODEL/commonviewmodel.dart';
import 'package:courier/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({super.key});

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
 
  final TextEditingController feedbackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  CommonViewModel? vm;
  bool isAccepted = false;
  
  String username = ""; // Store the email (username)

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  /// Load email (username) from SharedPreferences
  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('email') ?? ""; // Retrieve stored email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "How was your experience?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
             
              const SizedBox(height: 30),
              TextField(
                controller: feedbackController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: " Feedback",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Container(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xfff071e30),
                        ),
                        child: TextButton(
                          onPressed: (isAccepted= true)
                              ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    vm = Provider.of<CommonViewModel>(context,
                                        listen: false);
                                    //  final String username ="yaami@gmail.com";
                                        // vm!.loginData!.data!.username!;
                                    final String comments =
                                        feedbackController.text;

                                    await vm!
                                        .fetchfeedback(
                                            username,
                                            comments)
                                        .then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return MyHomePage();
                                      }));
                                    }).catchError((error) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Error: ${error.toString()}")));
                                    });
                                  }
                                }
                              : null,
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
