import 'dart:io';

import 'package:flutter/material.dart';
import 'package:istragaum/services/image_service.dart';

import 'photo.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late Future<Iterable<String>> images;

  @override
  void initState() {
    super.initState();
    ImageService imgService = ImageService();
    images = imgService.retrieveImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Iterable<String>>(
        future: images,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Iterable<String>? imgList = snapshot.data;

            return Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Photo(img: imgList!.elementAt(index)),
                      )),
                    },
                    child: Image.file(
                      File(imgList!.elementAt(index)),
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: imgList!.length,
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
