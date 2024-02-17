import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/category_model.dart';

class CategoryData {
  static List<CategoryModel> listOfCategories = [
    CategoryModel(
      name: 'Food',
      icon: const Icon(FontAwesomeIcons.burger),
      color: Colors.amber,
    ),
    CategoryModel(
      name: 'Clothes',
      icon: const Icon(FontAwesomeIcons.shirt),
      color: Colors.blue,
    ),
    CategoryModel(
      name: 'Healthcare',
      icon: const Icon(FontAwesomeIcons.notesMedical),
      color: Colors.green,
    ),
    CategoryModel(
      name: 'Entertainment',
      icon: const Icon(FontAwesomeIcons.film),
      color: Colors.redAccent,
    ),
    CategoryModel(
      name: 'Travel',
      icon: const Icon(FontAwesomeIcons.car),
      color: Colors.brown,
    ),


  ];
}
