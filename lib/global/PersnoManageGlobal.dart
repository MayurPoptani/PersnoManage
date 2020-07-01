import 'dart:io';

import 'package:persno_manage/Database/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersnoManageGlobal {
  static String _storagePath;
  static String get storagePath => _storagePath;
  static Database database;
  static Future<String> initializeStorage(String path) async {
    _storagePath = path;
    Directory dir = Directory(_storagePath);
    bool dirExists = dir.existsSync();
    print("Dir Exists = " + (dirExists?"True":"False, Trying To Creating Now"));
    if(!dirExists) {
      dir.createSync(recursive: true);
      dirExists = dir.existsSync();
      print("Dir Created = " + (dirExists ? "True" : "False, Failed To Create"));
    }
    database = Database(databasePath: databasePath);
    _preferences = await SharedPreferences.getInstance();
    print("called initializeStorage(String path)");
    return Future.value(dirExists?_storagePath:null);
  }
  static String get databasePath => _storagePath+"/database.sqlite";

  static SharedPreferences _preferences;

  static SharedPreferences get preferences => _preferences;

  static Future<bool> setAppThemeState(bool isDarkModeOn) async {
    await _preferences.setBool("DarkModeOn", isDarkModeOn);
    return _preferences.getBool("DarkModeOn");
  }

  static get isDarkModeOn => _preferences.getBool("DarkModeOn")??false;
  
}

