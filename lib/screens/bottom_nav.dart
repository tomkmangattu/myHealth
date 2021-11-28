import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myhealth/screens/bmi_page.dart';
import 'package:myhealth/screens/calorie_page.dart';
import 'package:myhealth/screens/pedometer_page.dart';
import 'package:myhealth/screens/tutorial.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    BmiPage(),
    CaloriePage(),
    PedometerPage(),
    TutorialPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.weight),
            label: 'BMI',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.utensils),
            label: 'Calorie',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.walking),
            label: 'Pedometer',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.play),
            label: 'Tutorial',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        iconSize: 16,
        unselectedFontSize: 12,
        selectedFontSize: 14,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}
