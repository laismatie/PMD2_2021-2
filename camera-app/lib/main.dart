import 'dart:async';

import 'package:camera/camera.dart';
import 'package:exemplo_camera/camera_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  /**
   * Garante a inicialização do plugin da câmera
   */
  WidgetsFlutterBinding.ensureInitialized();

  /**
   * Pega a lista de câmeras disponíveis no dispositivo
   */
  final cameras = await availableCameras();

  /**
   * Pega a primeira câmera da lista.
   * No smartphone, a câmera traseira.
   * No emulador, a webcam (câmera frontal).
   */
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    home: CameraApp(camera: firstCamera),
    debugShowCheckedModeBanner: false,
  ));
}
