import 'package:flutter/material.dart';
import 'package:vidente_app/controllers/cidade_controller.dart';
import 'package:vidente_app/controllers/tema_controller.dart';
import 'package:vidente_app/widgets/vidente_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load(fileName: '.env');
  await CidadeController.instancia.inicializarDB();
  await TemaController.instancia.inicializarDB();

  await CidadeController.instancia.inicializarCidade();
  await TemaController.instancia.inicializarTema();
  runApp(VidenteApp());
}
