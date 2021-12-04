import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:istragaum/widgets/filter/filter_selector.dart';

class PreviewImage extends StatelessWidget {
  PreviewImage({Key? key, required this.img}) : super(key: key);

  final XFile img;

  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

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
            Icons.close_rounded,
            color: Colors.black,
          ),
          label: Text(
            'Filtros',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: double.infinity,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: _buildPhotoWithFilter(img),
          ),
          Positioned.fill(
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithFilter(img) {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, value, child) {
        final color = value as Color;
        return Image.file(
          File(img.path),
          color: color.withOpacity(0.5),
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
