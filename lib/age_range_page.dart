import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omeyo_assignment/hooray.dart';

class AgeRangePage extends StatefulWidget {
  const AgeRangePage({super.key});

  @override
  State<AgeRangePage> createState() {
    return AgeRangePageState();
  }
}

class AgeRangePageState extends State<AgeRangePage> {

  final _form = GlobalKey<FormState>();
  int _currentPage = 4;
  int _totalPages = 11;

  RangeValues _currentRangeValues = const RangeValues(40, 80);

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    await FirebaseFirestore.instance.collection('users').doc('4').set({
      'agestart': _currentRangeValues.start.round().toString(),
      'ageend': _currentRangeValues.end.round().toString(),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  '$_currentPage/$_totalPages',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
        centerTitle: true,
        title: PreferredSize(
          preferredSize: Size.fromHeight(4.0), // Height of the progress bar
          child: LinearProgressIndicator(
            value: 0.2,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Age Range',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'You may change it later',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 30),
            RangeSlider(
              values: _currentRangeValues,
              max: 100,
              divisions: 5,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () {
            _submit();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: const HoorayPage(),
                ),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
