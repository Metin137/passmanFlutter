import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:passman/models/loginPassword_model.dart';
import 'package:passman/models/password_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  String _table = "passman";
  String _loginTable = "loginTable";
  String _loginTablePassword = "passwordLogin";
  String _loginTableHint = "passwordHint";
  String _columnID = "id";
  String _columnPasswordName = "passwordName";
  String _columnPasswordLogin = "passwordLogin";
  String _columnPassword = "password";
  String _columnPasswordInfo = "passwordInfo";

  Future<Database> get _getDatabase async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory appPath = await getApplicationDocumentsDirectory();

    String dbPath = join(appPath.path, 'passman12332.db');
    debugPrint("init: " + dbPath);
    var passmanDB = await openDatabase(dbPath, version: 1, onCreate: _createDB);

    return passmanDB;
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS $_table ($_columnID	INTEGER PRIMARY KEY AUTOINCREMENT, $_columnPasswordName	TEXT, $_columnPasswordLogin	TEXT, $_columnPassword	TEXT, $_columnPasswordInfo	TEXT)''');
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS $_loginTable ($_columnID	INTEGER PRIMARY KEY AUTOINCREMENT, $_loginTablePassword	TEXT, $_loginTableHint	TEXT)''');
  }

  Future close() async {
    final db = await instance._getDatabase;
    _database = null;
    db.close();
  }

  Future<int> addPassword(PasswordModel password) async {
    var db = await _getDatabase;
    var result =
        db.insert(_table, password.toMap(), nullColumnHack: "$_columnID");

    return result;
  }

  Future<List<Map<String, dynamic>>> getAllPassword() async {
    var db = await _getDatabase;

    var result = await db.query(_table, orderBy: '$_columnID DESC');

    return result;
  }

  Future<int> updatePassword(String id, PasswordModel password) async {
    var db = await _getDatabase;

    var result = await db.update(_table, password.toMap(),
        where: '$_columnID = ?', whereArgs: [id]);

    return result;
  }

  Future<int> deleteAllPassword() async {
    var db = await _getDatabase;

    var result = await db.delete(_table);

    return result;
  }

  Future<int> deletePassword(String id) async {
    var db = await _getDatabase;

    var result =
        await db.delete(_table, where: '$_columnID = ?', whereArgs: [id]);

    return result;
  }

  Future<int> addLoginPassword(LoginPasswordModel password) async {
    var db = await _getDatabase;
    var result =
        db.insert(_loginTable, password.toMap(), nullColumnHack: "$_columnID");

    return result;
  }

  Future<bool> checkLoginPasswordCount() async {
    var db = await _getDatabase;
    var result = await db.query(_loginTable, orderBy: '$_columnID DESC');

    return result.length != 0;
  }

  Future<bool> checkLoginPassword(String password) async {
    var db = await _getDatabase;
    var result = await db.query(_loginTable,
        where: '$_loginTablePassword = ?', whereArgs: [password]);

    return result.length != 0;
  }
}
