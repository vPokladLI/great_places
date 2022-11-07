import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<Database> db() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbHelper.db();

    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getAll(String table) async {
    final db = await DbHelper.db();
    final result = await db.query(table);
    return result;
  }

  static Future<void> delete(String table, String placeId) async {
    final db = await DbHelper.db();
    await db.delete(table, where: 'id = ?', whereArgs: [placeId]);
  }
}
