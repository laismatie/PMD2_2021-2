import 'package:camera/camera.dart';
import 'package:exemplo_camera/camera_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({Key? key, required this.camera}) : super(key: key);

  // Objeto contendo a câmera a ser utilizada
  final CameraDescription camera;

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  //Objeto capaz de controlar a câmera
  // do dispositivo.
  late CameraController _controller;
  // Guarda a Future que indicará o status
  // de inicialização da câmera
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
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
        title: const Text('CameraApp'),
        centerTitle: true,
      ),
      // É preciso utilizar um FutureBuilder,
      // pois a renderização deve aguardar a
      // inicialização da câmera.
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
            // Aguarda a câmera ser inicializada
            await _initializeControllerFuture;

            final image = await _controller.takePicture();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CameraPicture(imagePath: image.path),
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
