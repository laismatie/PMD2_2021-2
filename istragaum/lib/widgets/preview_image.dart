import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:istragaum/services/image_service.dart';

class PreviewImage extends StatelessWidget {
  PreviewImage({Key? key, required this.img}) : super(key: key);

  final XFile img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    File(img.path),
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () async {
                              ImageService service = ImageService();
                              await service.saveImage(img);
                              Navigator.pushNamed(context, '/home');
                            },
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/home'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
