import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TemaController extends ChangeNotifier {
  bool usarTemaEscuro;
  static TemaController instancia = TemaController();
  Future<Database> database;

  inicializarDB() async {
    /**
     * Tem que executar esse trem aqui
     */
    WidgetsFlutterBinding.ensureInitialized();
    this.database = openDatabase(join(await getDatabasesPath(), 'vidente.db'), version: 1, onCreate: (db, version) {
      return db.execute('CREATE TABLE tema (id INTEGER PRIMARY KEY, usarTemaEscuro  BOOLEAN)');
    });
  }

  TemaController() {
    usarTemaEscuro = false;
  }

  trocarTema() {
    usarTemaEscuro = !usarTemaEscuro;
    notifyListeners();
  }
}
