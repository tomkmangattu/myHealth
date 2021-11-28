import 'package:flutter/widgets.dart';
import 'package:myhealth/utils/food_item_model.dart';

class FoodList extends ChangeNotifier {
  List<Item> items = [];
  double totalCalories = 0;

  void addItem(Item item) {
    items.add(item);
    totalCalories = totalCalories + item.calorie * item.multipler;
    totalCalories = totalCalories.floorToDouble();
    notifyListeners();
  }

  void deleteItem(int index) {
    totalCalories =
        totalCalories - items[index].calorie * items[index].multipler;
    totalCalories = totalCalories.floorToDouble();
    items.removeAt(index);

    notifyListeners();
  }
}
