import 'package:flutter/material.dart';
import 'dart:io';

class Photo extends StatelessWidget {
  const Photo({Key? key, required this.img}) : super(key: key);
  final String img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton.icon(
          style: TextButton.styleFrom(alignment: Alignment.centerLeft),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          label: Text(
            'Foto',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: double.infinity,
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
