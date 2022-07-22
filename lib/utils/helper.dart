import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class StoresDatabase {
  static final StoresDatabase _instance = StoresDatabase._();
  static Database? _database;
  Database? get myDb => _database;
  StoresDatabase._();

  factory StoresDatabase() {
    return _instance;
  }

  Future<Database?> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();

    return _database;
  }

  // Get sum of all total costs from purchases table
  Future calculateTotal() async {
    // Query the table for all The purchases.
    var db = _database;
    var res =
        await db!.rawQuery("SELECT SUM(total_cost) as TOTAL FROM purchases");
    return res.toList();
  }

  Future<Database> initDB() async {
    Directory directory = await path.getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'stores.db');
    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      password TEXT)
  ''');
    db.execute('''
      CREATE TABLE purchases(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_name TEXT,
        description TEXT,
        quantity REAL,
        unit TEXT,
        buying_price REAL,
        total_cost REAL,
        date_purchased BLOB
        )
    ''');
  }

/*id
item_name
description
quantity
unit_buying_price
total_cost
date_purchased
*/
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  String generateID() {
    var uuid = const Uuid();
    return uuid.v1();
  }
}
