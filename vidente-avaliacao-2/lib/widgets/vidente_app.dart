import 'package:flutter/material.dart';
import 'package:vidente_app/controllers/cidade_controller.dart';
import 'package:vidente_app/controllers/tema_controller.dart';
import 'package:vidente_app/widgets/configuracoes.dart';
import 'package:vidente_app/widgets/home.dart';

class VidenteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: TemaController.instancia,
      builder: (context, child) {
        print(TemaController.instancia.temaEscolhido.lightDark);
        return MaterialApp(
            title: 'Vidente',
            theme: TemaController.instancia.temaEscolhido.lightDark == 0 ||
                    TemaController.instancia.temaEscolhido == 0
                ? ThemeData.light()
                : ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: CidadeController.instancia.cidadeEscolhida != null
                ? Home()
                : Configuracoes(),
            routes: {
              '/home': (context) => Home(),
              '/configuracoes': (context) => Configuracoes(),
            });
      },
    );
  }
}
