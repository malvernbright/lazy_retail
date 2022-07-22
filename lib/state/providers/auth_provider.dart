import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/user.dart';
import '../../utils/helper.dart';

class AuthProvider with ChangeNotifier {
  StoresDatabase storesDB = StoresDatabase();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<int> signUp(User user) async {
    var client = await storesDB.db;
    var authUser = client!.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _isLoggedIn = true;
    notifyListeners();
    return authUser;
  }

  void logout() {
    notifyListeners();
  }

  Future login(String name, String password) async {
    var client = await storesDB.db;
    // final Future<List<Map<String, dynamic>>> futureMaps = client!.rawQuery(
    //     "SELECT * FROM user WHERE name = '$name' and password = '$password'");
    final Future<List<Map<String, dynamic>>> futureMaps = client!.query('user',
        where: 'name = ? and password = ?', whereArgs: [name, password]);
    var maps = await futureMaps;

    if (maps.isNotEmpty) {
      _isLoggedIn = true;
      // return User.fromMap(maps.first);
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
    // return null;
  }
}
