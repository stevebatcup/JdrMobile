import 'package:flutter/material.dart';
import 'package:jdr/datamodels/category.dart';
import 'package:jdr/ui/components/category_chip.dart';

class CategoryList extends StatefulWidget {
  final Function onSelectCategory;

  CategoryList({this.onSelectCategory});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Category> rootCategories = Category.getRootCategories();

  void onSelectChip(Category category) {
    setState(() {
      Category.setSelected(list: rootCategories, selected: category);
      widget.onSelectCategory(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        height: 48,
        child: ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: rootCategories.asMap().entries.map(
            (rootEntry) {
              int rootIdx = rootEntry.key;
              Category rootCategory = rootEntry.value;
              return Row(
                children: <Widget>[
                  CategoryChip(
                    category: rootCategory,
                    idx: 'root_$rootIdx',
                    onSelect: () {
                      onSelectChip(rootCategory);
                    },
                  ),
                  Row(
                    children: rootCategory.childCategories
                        .asMap()
                        .entries
                        .map((entry) {
                      int idx = entry.key;
                      Category category = entry.value;
                      return CategoryChip(
                        category: category,
                        idx: 'cat_$idx',
                        onSelect: () {
                          onSelectChip(category);
                        },
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
