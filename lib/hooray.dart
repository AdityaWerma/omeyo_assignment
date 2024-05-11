import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:omeyo_assignment/birthday_page.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class HoorayPage extends StatefulWidget {
  const HoorayPage({super.key});

  @override
  State<HoorayPage> createState() {
    return HoorayPageState();
  }
}

class HoorayPageState extends State<HoorayPage> {
  final _form = GlobalKey<FormState>();
  var _username = '';
  var _dob = '';
  var _identify = '';
  var _agestart = '';
  var _ageend = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc('1').get();
    if (snapshot.exists) {
      setState(() {
        _username = snapshot['username'];
      });
    }

    DocumentSnapshot snapshot2 =
        await firestore.collection('users').doc('2').get();
    if (snapshot2.exists) {
      setState(() {
        _dob = snapshot['dob'];
      });
    }

    DocumentSnapshot snapshot3 =
        await firestore.collection('users').doc('3').get();
    if (snapshot3.exists) {
      setState(() {
        _identify = snapshot['identity'];
      });
    }

    DocumentSnapshot snapshot4 =
        await firestore.collection('users').doc('4').get();
    if (snapshot4.exists) {
      setState(() {
        _agestart = snapshot['agestart'];
        _ageend = snapshot['ageend'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/hooray_animation.json',
                width: 200, height: 200),
            Text('Hooray!!',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('You have successfully onboarded.'),
            SizedBox(height: 10,),
            Text('Name : $_username',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 84, 83, 83),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
