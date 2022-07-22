import 'package:flutter/foundation.dart';
import 'package:lazy_retail/models/purchase.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/helper.dart';

class StoresProvider with ChangeNotifier {
  StoresDatabase storesDB = StoresDatabase();
  List<Purchase> _purchasesInDB = [];
  List<Purchase> get purchasesInDB => _purchasesInDB;

  double _totalAmountSpent = 0;
  double get totalAmountSpent => _totalAmountSpent;
// A method that retrieves all the purchases from the purchases table.
  Future<List<Purchase>> purchases() async {
    // Get a reference to the database.
    final db = await storesDB.db;
    // Query the table for all The purchases.
    var res = await db!.query('purchases');
    if (res.isNotEmpty) {
      _purchasesInDB = res.map((items) => Purchase.fromJson(items)).toList();
    } else {
      _purchasesInDB = [];
    }
    notifyListeners();
    return _purchasesInDB;
  }

  Future<int> recordPurchase(Purchase purchase) async {
    var client = await storesDB.db;
    var item = client!.insert(
      'purchases',
      purchase.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await calculateTotalAmountSpent();
    notifyListeners();
    return item;
  }

// Get sum of all total costs from purchases table
  Future calculateTotalAmountSpent() async {
    var totalSum = (await storesDB.calculateTotal())[0]['TOTAL'];
    _totalAmountSpent = totalSum;
    notifyListeners();
  }
}
