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
  //Objeto capaz de controlar a câmera
  // do dispositivo.
  late CameraController _controller;
  // Guarda a Future que indicará o status
  // de inicialização da câmera
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      MyCameraController.instance.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();

    // Utilizado somente para garantir que
    // a orientação da webcam ficará correta.
    // Deve ser comentado/removido quando for
    // gerar o APK para o dispositivo real.
    _controller.lockCaptureOrientation(DeviceOrientation.landscapeRight);
  }

  @override
  void dispose() {
    // Libera a câmera quando o widget
    // for removido (ex: app encerrado)
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Câmera',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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
        child: const Icon(Icons.camera),
      ),
    );
  }
}
