import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? Color(0xfff071e30) : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}