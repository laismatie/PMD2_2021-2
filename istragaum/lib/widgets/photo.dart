import 'package:flutter/material.dart';
import 'dart:io';

class Photo extends StatelessWidget {
  const Photo({Key? key, required this.img}) : super(key: key);
  final String img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Photo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.file(
              File(img),
              fit: BoxFit.fill,
            ),
            elevation: 5,
            margin: EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
