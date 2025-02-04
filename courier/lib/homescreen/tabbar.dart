

import 'package:courier/Provider/sammeryprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tabbar extends StatelessWidget {
  const Tabbar({super.key});
  String _capitalizeWords(String text) {
  if (text.isEmpty) return text;
  return text
      .split(' ') // Split the string into words
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()) // Capitalize the first letter
      .join(' '); // Join the words back into a single string
}


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 239, 239),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TabBar(
              indicatorColor: Color(0xfff071e30),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              tabs: [
                Tab(text: "From me"),
                Tab(text: "To me"),
              ],
            ),
            Container(
              height: 150,
              child: TabBarView(
                children: [
                  // "From Me" Tab
                  Consumer<SummaryProvider>(
                    builder: (context, provider, child) {
                      if (provider.packageContents.isNotEmpty) {
                        return ListView.builder(
                          itemCount: provider.packageContents.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                
                                // leading: Icon(Icons.check_box, color: Colors.green),
                                title: Text(
                                  _capitalizeWords(provider.packageContents[
                                      index]), // Capitalize the first letter of each word
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/Untitled_design-removebg-preview.png",
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              "You haven't sent any package yet!!!",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  // "To Me" Tab
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/Untitled_design-removebg-preview.png",
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "There are no active orders right now!!!",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
