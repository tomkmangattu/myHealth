import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhealth/utils/food_item_model.dart';
import 'dart:developer';

import 'package:myhealth/utils/food_list_provider.dart';
import 'package:provider/provider.dart';

class AddFoodItemPage extends StatefulWidget {
  const AddFoodItemPage({Key? key}) : super(key: key);

  @override
  _AddFoodItemPageState createState() => _AddFoodItemPageState();
}

class _AddFoodItemPageState extends State<AddFoodItemPage> {
  bool _loading = true;
  late final List<FoodCategory> _foodItems;
  late FoodCategory _selectedCategory;
  late List<Item> _selectedItems;
  late Item _selectedItem;
  String multipler = '1';

  @override
  void initState() {
    _loadJsonData();
    super.initState();
  }

  void _loadJsonData() async {
    final String data = await rootBundle.loadString("assets/food_calorie.json");
    _foodItems = foodCategoryFromJson(data);
    setState(() {
      _loading = false;
    });
    _selectedCategory = _foodItems[0];
    _selectedItems = _foodItems[0].items;
    _selectedItem = _foodItems[0].items[0];
    log('loading completed .....');
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Food Item'),
      ),
      body: _loading
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _label(
                      label: 'Catergory', color: Theme.of(context).hintColor),
                  DropdownSearch<FoodCategory>(
                    items: _foodItems,
                    maxHeight: _height * 2 / 3,
                    mode: Mode.BOTTOM_SHEET,
                    selectedItem: _selectedCategory,
                    itemAsString: (FoodCategory? category) =>
                        category!.category,
                    onChanged: (FoodCategory? category) {
                      if (category != null) {
                        setState(() {
                          _selectedItems = category.items;
                          _selectedItem = _selectedItems[0];
                        });
                      }
                    },
                    dropdownSearchDecoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _label(
                    label: 'Item',
                    color: Theme.of(context).hintColor,
                  ),
                  DropdownSearch<Item>(
                    selectedItem: _selectedItems[0],
                    items: _selectedItems,
                    maxHeight: _height * 2 / 3,
                    itemAsString: (Item? item) => item!.item,
                    mode: Mode.BOTTOM_SHEET,
                    onChanged: (Item? item) {
                      if (item != null) {
                        setState(() {
                          _selectedItem = item;
                        });
                      }
                    },
                    dropdownSearchDecoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Weight/Volume (g or ml)'),
                        Flexible(
                          child: TextFormField(
                            initialValue: '1',
                            maxLength: 5,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            onChanged: (String? val) {
                              if (val != null) {
                                setState(() {
                                  multipler = val;
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: '',
                              hintText: '1',
                            ),
                          ),
                        ),
                        Text(' x ' + _selectedItem.quantity),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Energy (Kcals) :'),
                        Text(
                          (_selectedItem.calorie *
                                  (((double.tryParse(multipler)) != null)
                                      ? double.parse(multipler)
                                      : 1))
                              .toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onpressed,
        child: const Icon(Icons.send),
      ),
    );
  }

  void _onpressed() {
    log(_selectedItem.item);
    log(multipler);
    double m = 1;
    if (multipler.isNotEmpty) {
      if (double.tryParse(multipler) != null) {
        m = double.tryParse(multipler) ?? 1;
      }
    }
    final Item item = Item(
      item: _selectedItem.item,
      quantity: _selectedItem.quantity,
      calorie: _selectedItem.calorie,
      multipler: m,
    );
    Provider.of<FoodList>(context, listen: false).addItem(item);
    Navigator.pop(context);
  }

  Align _label({required String label, required Color color}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 12,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
