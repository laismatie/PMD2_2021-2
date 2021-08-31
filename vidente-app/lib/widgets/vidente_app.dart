import 'package:flutter/material.dart';
import 'package:vidente_app/controllers/tema_controller.dart';
import 'package:vidente_app/widgets/configuracoes.dart';

class VidenteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: TemaController.instancia,
      builder: (context, child) {
        return MaterialApp(
          title: 'Vidente',
          theme: TemaController.instancia.usarTemaEscuro ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: new Configuracoes(),
        );
      },
    );
  }
}
