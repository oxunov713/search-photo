import 'package:flutter/material.dart';

class IfOffline extends StatelessWidget {
  const IfOffline({super.key, required this.assetImage});

  final String assetImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Image(height: 600,width: double.infinity,
                fit: BoxFit.fill,
                image: AssetImage(assetImage),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Ko'proq rasm olish uchun Internetingizni yoqing",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
