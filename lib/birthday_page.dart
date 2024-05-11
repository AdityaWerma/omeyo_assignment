import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omeyo_assignment/identify_as_page.dart';

class BirthdayPage extends StatefulWidget {
  const BirthdayPage({super.key});

  @override
  State<BirthdayPage> createState() {
    return BirthdayPageState();
  }
}

class BirthdayPageState extends State<BirthdayPage> {
  final _form = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  int _currentPage = 2;
  int _totalPages = 11;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    await FirebaseFirestore.instance.collection('users').doc('2').set({
      'dob': _selectedDate.toString(),
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
              'My Birthday is on...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We need this information to ensure you\'re old enough to safely use Blush',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 100),
            Form(
              key: _form,
              child: Container(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
            ),
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
                  child: const IdentifyAsPage(),
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
