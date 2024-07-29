import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      color: Colors.deepOrange.shade800,
      child: Row(
        children: [
          BackButton(
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            "Orqaga qaytish",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
