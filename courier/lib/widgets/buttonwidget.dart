import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ButtonWidget extends StatelessWidget {
  String title;
  double heightsize, widthsize;
  final VoidCallback onTap;
  Color buttoncolor;
  Color textcolor;
  ButtonWidget({
    required this.title,
    required this.heightsize,
    required this.widthsize,
    required this.onTap,
    required this.buttoncolor,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: heightsize,
        width: widthsize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: buttoncolor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 8, // Blur radius
              offset: Offset(0, 4), // Changes position of shadow (x, y)
            ),
          ],
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: textcolor, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
