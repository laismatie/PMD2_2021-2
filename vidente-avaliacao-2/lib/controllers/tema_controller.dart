import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vidente_app/models/tema.dart';

class TemaController extends ChangeNotifier {
  Tema temaEscolhido;
  static TemaController instancia = TemaController();
  Future<Database> database;

  inicializarDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    this.database = openDatabase(join(await getDatabasesPath(), 'vidente.db'),
        version: 1, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tema (id INTEGER PRIMARY KEY, lightDark INTEGER)');
    });
  }

  inicializarTema() async {
    print('INICIALIZAR TEMA');
    final db = await this.database;
    List<Map<String, dynamic>> tema = await db.query('tema');
    print(tema);
    this.temaEscolhido = tema.length > 0 ? Tema(tema[0]['lighDark']) : null;
  }

  salvarTema(Tema tema) async {
    final db = await this.database;
    List<Map<String, dynamic>> temas = await db.query('tema');

    if (temas.length > 0) {
      await db.update(
        'tema',
        tema.toMap(),
        where: 'id = ?',
        whereArgs: [1],
      );
    } else {
      await db.insert(
        'tema',
        tema.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  trocarTema(Tema tema) async {
    temaEscolhido = tema;
    salvarTema(tema);
    notifyListeners();
  }
}
