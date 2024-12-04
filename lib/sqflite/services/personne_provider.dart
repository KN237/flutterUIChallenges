import 'package:challenges/sqflite/models/personne.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = 'Personne';
const String colonneId = 'id';
const String colonneNom = 'nom';
const String colonnePrenom = 'prenom';
const String colonneAge = 'age';
const String databaseName = 'personne.db';
const int databaseVersion = 1;

class PersonneProvider {
  Database? _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await _initDatabase();
      return _db!;
    }
  }

  Future<Database> _initDatabase() async {
    final doc = await getApplicationDocumentsDirectory();
    String path = join(doc.path, databaseName);
    return await openDatabase(path, version: databaseVersion, onOpen: _open);
  }

  void _open(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tableName ($colonneId INTEGER PRIMARY KEY AUTOINCREMENT, $colonneNom TEXT,$colonnePrenom TEXT,  $colonneAge  INTEGER)');
  }

  Future<int> insert(Personne p) async {
    Database d = await db;
    return await d.insert(tableName, p.toMap());
  }

  Future<int> delete(int id) async {
    Database d = await db;
    return await d.delete(tableName, where: 'id=?', whereArgs: [id]);
  }

  Future<Personne?> query(int id) async {
    Database d = await db;
    List<Map<String, dynamic>> maps = [];
    maps = await d.query(
      tableName,
      columns: [colonneId, colonneNom, colonnePrenom, colonneAge],
      where: '$colonneId = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    }

    return Personne.fromMap(maps.first);
  }

  Future<Personne?> query2() async {
    Database d = await db;
    List<Map<String, dynamic>> maps = [];
    maps = await d.query(
      tableName,
    );
    if (maps.isEmpty) {
      return null;
    }

    return Personne.fromMap(maps.first);
  }

  Future close() async {
    Database d = await db;
    await d.close();
  }
}
