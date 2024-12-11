import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageThird extends StatelessWidget {
  const PageThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 1, 42),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Header Section
                Text(
                  'Book Request',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Form Section
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextField("Book Title", TextInputType.text),
                      const SizedBox(height: 16),
                      _buildTextField("Author Name", TextInputType.text),
                      const SizedBox(height: 16),
                      _buildTextField("Genre", TextInputType.text),
                      const SizedBox(height: 16),
                      _buildTextField("Description", TextInputType.text),
                      const SizedBox(height: 16),
                      _buildTextField("Publication Year", TextInputType.number),
                      const SizedBox(height: 16),
                      _buildTextField("Your Email", TextInputType.emailAddress),
                      const SizedBox(height: 36),

                      // Submit Button
                      ElevatedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                          msg: "Message sent",
                          toastLength: Toast.LENGTH_SHORT, // Short duration
                          gravity: ToastGravity.BOTTOM,   // Position of the toast
                          timeInSecForIosWeb: 1, // iOS duration in seconds
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
            );

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                          shadowColor: Colors.black.withOpacity(0.4),
                        ),
                        child: Text(
                          'Submit Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Footer Section
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Modern styled text field with better design and animation
  Widget _buildTextField(String label, TextInputType keyboardType) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextFormField(
          keyboardType: keyboardType,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purpleAccent, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  // Footer with Copyrights and Information
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '© 2024 Library Management. All Rights Reserved.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

