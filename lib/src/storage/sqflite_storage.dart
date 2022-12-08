import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteStorage {
  static const _databaseName = 'image_cache.db';
  static const _databaseVersion = 1;

  static const table = 'images';

  static const columnUrl = 'url';
  static const columnEncodedImage = 'encodedImage';
  static const columnExpiredAt = 'expiredAt';

  // make this a singleton class
  SqfliteStorage._privateConstructor();
  static final SqfliteStorage instance = SqfliteStorage._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    Database? currentDatabase = _database;
    if (currentDatabase != null) {
      return currentDatabase;
    } else {
      // lazily instantiate the db the first time it is accessed
      Database initDatabase = await _initDatabase();
      _database = initDatabase;
      return initDatabase;
    }
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}$_databaseName';
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnUrl TEXT NOT NULL UNIQUE,
            $columnEncodedImage TEXT NOT NULL,
            $columnExpiredAt TEXT NOT NULL
          )
          ''');
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future insert(Map<String, dynamic> row) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> result = await db.query(
      table,
      where: '$columnUrl = ?',
      whereArgs: [row[columnUrl]],
    );

    if (result.isNotEmpty) {
      await update(row);
    } else {
      return await db.insert(table, row);
    }
  }

  Future<Map<String, dynamic>?> getSingleRow(String url) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      table,
      where: '$columnUrl = ?',
      whereArgs: [url],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String url = row[columnUrl];
    return await db
        .update(table, row, where: '$columnUrl = ?', whereArgs: [url]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> remove(String url) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnUrl = ?', whereArgs: [url]);
  }

  Future<int> removeAll() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
