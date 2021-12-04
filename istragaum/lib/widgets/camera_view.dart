import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istragaum/controllers/my_camera_controller.dart';
import 'package:istragaum/widgets/preview_image.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      MyCameraController.instance.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    _controller.lockCaptureOrientation(DeviceOrientation.landscapeRight);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            'Câmera',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: double.infinity,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image = await _controller.takePicture();

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PreviewImage(img: image),
            ));
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(
          Icons.camera,
          color: Colors.black,
        ),
      ),
    );
  }
}
