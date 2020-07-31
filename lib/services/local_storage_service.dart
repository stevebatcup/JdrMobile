import 'dart:convert';

import 'package:jdr/datamodels/category.dart';
import 'package:jdr/datamodels/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;
  static const String UserKey = 'user';
  static const String SessionCookieKey = 'session_cookie';
  static const String RootCategoriesKey = 'root_categories';
  static const String CategoriesKey = 'categories';

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    // print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveStringToDisk(String key, String content) {
    // print(
    // '(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    _preferences.setString(key, content);
  }

  User get user {
    var userJson = _getFromDisk(UserKey);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

  set user(User userToSave) {
    _saveStringToDisk(UserKey, json.encode(userToSave.toJson()));
  }

  String get sessionCookie => _getFromDisk(SessionCookieKey);

  set sessionCookie(String cookie) {
    _saveStringToDisk(SessionCookieKey, cookie);
  }

  void clearUserData() {
    _preferences.clear();
  }

  void saveCategoriesList({List rootCategories, List categories}) {
    _saveStringToDisk(RootCategoriesKey, json.encode(rootCategories));
    _saveStringToDisk(CategoriesKey, json.encode(categories));
  }

  List<Category> getRootCategories() {
    var rootCategoryJson = _getFromDisk(RootCategoriesKey);
    List<Category> list = [];

    if (rootCategoryJson != null) {
      list = json.decode(rootCategoryJson).map<Category>((catJson) {
        return Category.fromJson(catJson);
      }).toList();
    }
    return list;
  }

  List<Category> getCategoriesForRootId(id) {
    var categoryJson = _getFromDisk(CategoriesKey);
    List<Category> list = [];

    if (categoryJson != null) {
      list = json
          .decode(categoryJson)
          .where((cat) => cat['rootCategoryId'] == id)
          .map<Category>((catJson) => Category.fromJson(catJson))
          .toList();
    }
    return list;
  }
}
