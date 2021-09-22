import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TemaController extends ChangeNotifier {
  bool usarTemaEscuro;
  static TemaController instancia = TemaController();
  Future<Database> database;

  inicializarDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    this.database = openDatabase(join(await getDatabasesPath(), 'vidente.db'),
        version: 1, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tema (meutema BOOLEAN NOT NULL CHECK (meutema IN (0, 1)))');
    });
  }

  TemaController() {
    usarTemaEscuro = false;
  }

  trocarTema() async {
    final db = await this.database;

    usarTemaEscuro = !usarTemaEscuro;

    if (usarTemaEscuro == false) {}
    notifyListeners();
  }
}
