import 'package:courier/Screen/email/otpscreen.dart';
import 'package:email_otp/email_otp.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  @override
 final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  late String email;
  EmailOTP myauth = EmailOTP();
  bool isLoading = false;

//   Future<void> _saveEmailToPreferences(String email) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('email', email); 
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child:Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8, top: 300),
                  child: Column(
                    children: [
                      Text(
                        "Enter Your Email",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      else if (!RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      else if (value == "a@gmail.com" ||
                          value == "example@example.com" ||
                          value == "test@test.com") {
                        return 'Please enter a valid, real email address';
                      }
      
                      return null;
                    },
                          onChanged: (value) {
                            email = value; 
                          },
                          controller: emailController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "heloo@gmail.com",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xfff071e30),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              // await _saveEmailToPreferences(email);

                              myauth.setConfig(
                                appEmail: "zaaara00@gmail.com", 
                                appName: "Email OTP",
                                userEmail: email, 
                                otpLength: 6,
                                otpType: OTPType.digitsOnly,
                              );
                
                              bool otpSent = await myauth.sendOTP();
                              print("OTP sent result: $otpSent");
                              setState(() {
                                isLoading = false;
                              });
                              if (otpSent) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP has been sent")));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => OtpScreen(myauth: myauth,
                                  email: email)),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Oops, OTP send failed")));
                              }
                            }
                          },
                          child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          :Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Send OTP",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
           
        ),
      ),
    );
  }
}