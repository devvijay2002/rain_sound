import 'package:flutter/material.dart';

class RoundedCornerContainerApp extends StatelessWidget {
  const RoundedCornerContainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,  // Width of the container
      height: 100,  // Height of the container
      decoration: const BoxDecoration(
        color: Colors.red,  // Background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),  // Top-left corner
          topRight: Radius.circular(10.0), // Top-right corner
          bottomLeft: Radius.circular(20.0), // Bottom-left corner
          bottomRight: Radius.circular(40.0), // Bottom-right corner
        ),
      ),
      child: const Center(
        child: Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}