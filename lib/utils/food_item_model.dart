// To parse this JSON data, do
//
//     final foodCategory = foodCategoryFromJson(jsonString);

import 'dart:convert';

List<FoodCategory> foodCategoryFromJson(String str) => List<FoodCategory>.from(
    json.decode(str).map((x) => FoodCategory.fromJson(x)));

String foodCategoryToJson(List<FoodCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodCategory {
  const FoodCategory({
    required this.category,
    required this.items,
  });

  final String category;
  final List<Item> items;

  factory FoodCategory.fromJson(Map<String, dynamic> json) => FoodCategory(
        category: json["category"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  const Item({
    required this.item,
    required this.quantity,
    required this.calorie,
    this.multipler = 1,
  });

  final String item;
  final String quantity;
  final double calorie;
  final double multipler;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        item: json["Item"],
        quantity: json["Quantity"],
        calorie: double.parse(json["Calorie"]),
      );

  Map<String, dynamic> toJson() => {
        "Item": item,
        "Quantity": quantity,
        "Calorie": calorie,
      };
}
