import 'package:flutter/material.dart';
import 'package:myhealth/utils/food_item_model.dart';
import 'package:myhealth/utils/food_list_provider.dart';
import 'package:provider/provider.dart';

class CaloriePage extends StatefulWidget {
  const CaloriePage({Key? key}) : super(key: key);

  @override
  State<CaloriePage> createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Calculator'),
      ),
      body: Consumer<FoodList>(
        builder: (context, FoodList food, child) {
          final List<Item> items = food.items;
          if (items.isEmpty) {
            return const SizedBox();
          } else {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return Container(
                  padding: const EdgeInsets.all(12),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).highlightColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      _itemRows(name: 'Item', value: item.item),
                      _itemRows(
                          name: 'Quantity',
                          value: ' ${item.item} * ${item.multipler}'),
                      _itemRows(
                        name: 'Calorie',
                        value: (item.calorie * item.multipler).toString(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/addFoodItem");
        },
      ),
    );
  }

  Row _itemRows({required String name, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text(value),
      ],
    );
  }
}
