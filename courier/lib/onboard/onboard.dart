import 'package:courier/Screen/email/login.dart';
import 'package:courier/onboard/listonboard.dart';
import 'package:courier/widgets/buttonwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: screen.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              itemBuilder: (context, index) => ImageModel(
                image: screen[index].image,
                title: screen[index].title,
                desc: screen[index].desc,
                showDotIndicator: true,
                pageIndex: _pageIndex,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _pageIndex == screen.length - 1
                ? Container(
                    child: ButtonWidget(
                        buttoncolor: Color(0xfff071e30),
                        title: "Get Started",
                        heightsize: 40,
                        widthsize: MediaQuery.of(context).size.width,
                        textcolor: Colors.white,
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return EmailLogin();
                              },
                            ))),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return EmailLogin();
                            },
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "SKIP",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 195,130,77),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: ButtonWidget(
                          title: "NEXT",
                          heightsize: 40,
                          widthsize: 70,
                          buttoncolor: Color(0xfff071e30),
                          textcolor: Colors.white,
                          onTap: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}