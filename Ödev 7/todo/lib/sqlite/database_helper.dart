import 'dart:io';

import 'package:flutter/services.dart';
import 'package:kisiler/data/constants/database_constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> databaseAccess() async {
    String databasePath =
        join(await getDatabasesPath(), DatabaseConstants.databaseName);

    if (!await databaseExists(databasePath)) {
      ByteData data =
          await rootBundle.load("database/${DatabaseConstants.databaseName}");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(databasePath);
  }
}
