import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  Future<Iterable<String>> retrieveImages() async {
    final directory = await getApplicationDocumentsDirectory();
    Iterable<String> images =
        directory.listSync().map((item) => item.path).where((item) => item.endsWith('.jpg')).toList().reversed;

    return images;
  }

  saveImage(XFile image, Color color) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final fileName = basename(image.path);

    final filteredImage = Image.file(
      File(image.path),
      color: color.withOpacity(0.5),
      colorBlendMode: BlendMode.color,
    );

    await image.saveTo('$path/$fileName');
  }
}
