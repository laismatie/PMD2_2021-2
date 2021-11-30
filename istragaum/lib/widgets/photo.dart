import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  final img;
  const Photo({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Photo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Image.asset(
          img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
