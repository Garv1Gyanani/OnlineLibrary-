import 'package:flutter/material.dart';
import 'package:library_management/VIew/Page2_.dart';
import 'package:library_management/VIew/dashbord.dart';
import 'package:library_management/VIew/page3.dart';
import 'package:library_management/VIew/side_bar.dart';

class Website extends StatelessWidget {
  const Website({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 7, 26), // Dark background for the page
      body: Row(
        children: [
          Sidebar(),

          // Scrollable content for Dashboard and Second Page
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Dashboard Page
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: DashboardPage(),
                  ),

                  // Second Page
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PageSecond(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PageThird(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
