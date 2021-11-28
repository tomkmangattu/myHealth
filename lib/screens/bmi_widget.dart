import 'package:flutter/material.dart';

class BmiWidget extends StatelessWidget {
  final int bmi;
  const BmiWidget({
    Key? key,
    required this.bmi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your Body Mass Index is : '),
              Text(bmi.toString()),
            ],
          ),
          const SizedBox(height: 20),
          _message(bmi),
        ],
      ),
    );
  }

  Widget _message(int bmi) {
    if (bmi < 18) {
      return const Text('This is considered underweight');
    } else if (bmi > 25) {
      return const Text('This is considered obese');
    }
    return const Text('This is considered normal');
  }
}
