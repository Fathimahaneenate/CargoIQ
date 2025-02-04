import 'package:courier/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,top: 250),
                child: Lottie.asset("assets/animation/Animation4.json",
                height: 200),
              ),
              // Positioned(
              //   top: 550,
              //   right: 0,
              //   left: 0,
              //   // bottom: 50,
              //   child: Text("Order Confirmed !",
              //   style: TextStyle(color: Colors.green,fontSize: 30,fontWeight: FontWeight.bold),),
              // ),
      
              const SizedBox(height: 80),
            Padding(
              padding:  EdgeInsets.all(16.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff071e30)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 390,left: 85),
            child: Text("Order Confirmed !",
                  style: TextStyle(color: Colors.green,fontSize: 35,fontWeight: FontWeight.bold),),
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 440,left: 100),
            child: Text("       Thank you for your order,\nOur team will contact you shortly.",
                  style: TextStyle(color: Colors.grey[500],fontSize: 15,),),
          ),
          
        ],
      ),
      
    );
  }
}