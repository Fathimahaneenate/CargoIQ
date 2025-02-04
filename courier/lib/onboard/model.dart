import 'package:courier/onboard/listonboard.dart';
import 'package:flutter/cupertino.dart';
import 'dotindicator.dart';

class ImageModel extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final bool showDotIndicator;
  final int pageIndex;

  const ImageModel({
    required this.image,
    required this.title,
    required this.desc,
    this.showDotIndicator = false,
    required this.pageIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        if (showDotIndicator)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                screen.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: DotIndicator(
                    isActive: index == pageIndex,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}