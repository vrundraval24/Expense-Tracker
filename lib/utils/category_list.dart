import 'package:flutter/material.dart';

import '../data/category_data.dart';

class CategoryList {

  static final List<DropdownMenuItem<Object>> dropdownMenuEntryList = [];

  static void createDropDownMenu() {
    print("create drop down menu called");

    for (var category in CategoryData.listOfCategories) {
      dropdownMenuEntryList.add(
        DropdownMenuItem(
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Icon(
                category.icon.icon,
                size: 18,
                // color: category.color,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                category.name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          value: category.name,
        ),
      );
    }
  }

}