import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:myhealth/screens/add_food_page.dart';
import 'package:myhealth/screens/bottom_nav.dart';
import 'package:myhealth/utils/food_list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodList>(
      create: (_) => FoodList(),
      child: MaterialApp(
        // The Mandy red, light theme.
        theme: FlexThemeData.light(scheme: FlexScheme.blueWhale),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.blueWhale),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (_) => const MyNavigationBar(),
          '/addFoodItem': (_) => const AddFoodItemPage(),
        },
      ),
    );
  }
}
