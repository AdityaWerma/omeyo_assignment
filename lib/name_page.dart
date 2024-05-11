import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omeyo_assignment/birthday_page.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() {
    return NamePageState();
  }
}

class NamePageState extends State<NamePage> {
  final _form = GlobalKey<FormState>();
  var _enteredUsername = '';
  int _currentPage = 1;
  int _totalPages = 11;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    await FirebaseFirestore.instance.collection('users').doc('1').set({
      'username': _enteredUsername.toString(),
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
            value: 0.1,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'My name is...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 4) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _enteredUsername = value!;
                      });
                    },
                  ),
                ],
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
                  child: const BirthdayPage(),
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
