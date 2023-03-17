import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDataBase{

  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'UserDb.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "UserDb.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join('assets/database', 'UserDb.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String, Object?>>> getUserListFromTable() async {
    Database db = await initDatabase();
    List<Map<String, Object?>> data  = await db.rawQuery('select UserId,Name,CityName,Dob from Tbl_User');
    return data;
  }

  Future<int> InsertUser(map) async {
    Database db = await initDatabase();
    int UserId = await db.insert("Tbl_User", map);
    return UserId;
  }
  Future<int> UpdatetUser(map,id) async {
    Database db = await initDatabase();
    int UserId = await db.update("Tbl_User", map,where: "UserId = ?",whereArgs: ["id"]);
    return UserId;
  }
}