import 'dart:developer';
import 'package:courier/Drawer/createaccount.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.myauth, required this.email})
      : super(key: key);
  final EmailOTP myauth;
  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinputController = TextEditingController();
  String? pinnumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 300),
                child: Text(
                  "Please enter the verification code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                  controller: _pinputController,
                  pinAnimationType: PinAnimationType.fade,
                  onChanged: (pin) {
                    log("Inside onChanged: $pin");
                    setState(() {
                      pinnumber = pin;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff071e30),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (pinnumber != null && pinnumber!.length == 6) {
                      bool otpVerified;
                      try {
                        otpVerified = await widget.myauth.verifyOTP(otp: pinnumber!);
                        print("OTP verification result: $otpVerified");
                      } catch (error) {
                        otpVerified = false;
                        print("Error verifying OTP: $error");
                      }

                      if (otpVerified) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("OTP is verified")),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  CreateProfilePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid OTP")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
                      );
                    }
                  },
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
