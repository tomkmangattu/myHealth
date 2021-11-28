import 'package:flutter/widgets.dart';
import 'package:myhealth/utils/food_item_model.dart';

class FoodList extends ChangeNotifier {
  List<Item> items = [];

  void addItem(Item item) {
    items.add(item);
    notifyListeners();
  }
}
