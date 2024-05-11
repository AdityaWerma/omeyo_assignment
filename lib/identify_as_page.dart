import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'age_range_page.dart';

class IdentifyAsPage extends StatefulWidget {
  const IdentifyAsPage({super.key});

  @override
  State<IdentifyAsPage> createState() {
    return IdentifyAsPageState();
  }
}

class IdentifyAsPageState extends State<IdentifyAsPage> {
  final _form = GlobalKey<FormState>();

  var _enteredIdentity = '';
  var _isSelectedMale = false;
  var _isSelectedFemale = false;
  var _isSelectedBinary = false;

  int _currentPage = 3;
  int _totalPages = 11;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    await FirebaseFirestore.instance.collection('users').doc('3').set({
      'identity': _enteredIdentity.toString(),
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
            value: 0.3,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'I identify as...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _enteredIdentity = 'male';
                      _isSelectedMale = true;
                      _isSelectedBinary = false;
                      _isSelectedFemale = false;
                    });

                  },
                  child: Column(
                    children: [
                      Ink.image(
                        height: _isSelectedMale ? 50 : 100,
                        width: 100,
                        image: AssetImage('assets/images/male_gender.png'),
                      ),
                      Text('Male'),
                    ],
                  ),
                ),
                SizedBox(width: 50,),
                InkWell(
                  onTap: () {

                    setState(() {
                      _enteredIdentity = 'female';
                      _isSelectedFemale = true;
                      _isSelectedBinary = false;
                      _isSelectedMale = false;
                    });

                  },
                  child: Column(
                    children: [
                      Ink.image(
                        height: _isSelectedFemale ? 50 : 100,
                        width: 100,
                        image: AssetImage('assets/images/woman_gender.png'),
                      ),
                      Text('Female'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            InkWell(
              onTap: () {
                setState(() {
                  _enteredIdentity = 'non-binary';
                  _isSelectedBinary = true;
                  _isSelectedMale = false;
                  _isSelectedFemale = false;
                });

              },
              child: Column(
                children: [
                  Ink.image(
                    height: _isSelectedBinary ? 50 : 100,
                    width: 100,
                    image: AssetImage('assets/images/non-binary.png'),
                  ),
                  Text('Non-binary'),
                ],
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
                  child: const AgeRangePage(),
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
