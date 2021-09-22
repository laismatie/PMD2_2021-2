import 'dart:io';

import 'package:flutter/material.dart';

class CameraPicture extends StatelessWidget {
  final String imagePath;

  const CameraPicture({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your pic')),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
