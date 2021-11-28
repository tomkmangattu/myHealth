import 'package:flutter/material.dart';
import 'package:myhealth/screens/bmi_widget.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  String _weight = '';
  String _height = '';

  final _formKey = GlobalKey<FormState>();
  int? _bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onChanged: (String value) {
                  _weight = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Weight in kg',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (String value) {
                  _height = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter height in centimeter',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  double? bmi = _onpress();
                  if (bmi == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong'),
                      ),
                    );
                  } else {
                    setState(() {
                      _bmi = bmi.round();
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Calculate',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              (_bmi != null) ? BmiWidget(bmi: _bmi!) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  double? _onpress() {
    if (_formKey.currentState!.validate()) {
      double? w = double.tryParse(_weight);
      double? h = double.tryParse(_height);
      if (w != null && h != null) {
        return w / (h * h) * 10000;
      }
    }
  }
}
