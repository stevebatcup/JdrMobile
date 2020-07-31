import 'package:jdr/app/locator.dart';
import 'package:jdr/services/local_storage_service.dart';

class Category {
  int id;
  String name;
  int rootCategoryId;
  bool isRoot;
  bool isSelected = false;
  List<Category> childCategories = [];

  static final LocalStorageService _storageService =
      locator<LocalStorageService>();

  static setSelected({List<Category> list, Category selected}) {
    list.forEach((rootCategory) {
      if (rootCategory != selected) rootCategory.isSelected = false;
      rootCategory.childCategories.forEach((childCategory) {
        if (childCategory != selected) childCategory.isSelected = false;
      });
    });
  }

  static List<Category> getRootCategories() {
    List<Category> rootCategories = _storageService.getRootCategories();
    rootCategories.forEach((rootCategory) {
      rootCategory.childCategories = getCategoriesForRootId(rootCategory.id);
    });
    return rootCategories;
  }

  static List<Category> getCategoriesForRootId(int id) {
    return _storageService.getCategoriesForRootId(id);
  }

  static void storeCategories({List rootCategories, List categories}) {
    _storageService.saveCategoriesList(
        rootCategories: rootCategories, categories: categories);
  }

  Category.fromJson(jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    if (jsonData.containsKey('rootCategoryId')) {
      isRoot = false;
      rootCategoryId = jsonData['rootCategoryId'];
    } else {
      isRoot = true;
    }
  }
}
