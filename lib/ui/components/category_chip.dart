import 'package:flutter/material.dart';
import 'package:jdr/datamodels/category.dart';

class CategoryChip extends StatefulWidget {
  const CategoryChip({
    Key key,
    @required this.category,
    @required this.idx,
    @required this.onSelect,
  }) : super(key: key);

  final Category category;
  final String idx;
  final Function onSelect;

  @override
  _CategoryChipState createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  Color getLabelColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ChoiceChip(
        elevation: 2.5,
        pressElevation: 1,
        backgroundColor: Colors.grey[300],
        selectedColor: Colors.grey[600],
        shadowColor: Colors.grey[700],
        selectedShadowColor: Colors.grey[500],
        labelStyle: TextStyle(
          fontSize: 14,
          color: MaterialStateColor.resolveWith(getLabelColor),
        ),
        label: Text(
          widget.category.isRoot
              ? widget.category.name.toUpperCase()
              : widget.category.name,
        ),
        selected: widget.category.isSelected,
        onSelected: (bool selected) {
          setState(() {
            widget.onSelect();
            widget.category.isSelected = !widget.category.isSelected;
          });
        },
      ),
    );
  }
}
