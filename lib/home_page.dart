// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:omeyo_assignment/age_range_page.dart';
// import 'package:omeyo_assignment/birthday_page.dart';
//
// import 'identify_as_page.dart';
// import 'name_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() {
//     return HomePageState();
//   }
// }
//
// class HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//
//    bool isFilled = true;
//   // final List<Widget> _pages = [
//   //   NamePage(),
//   //   BirthdayPage(),
//   //   IdentifyAsPage(),
//   //   AgeRangePage(),
//   // ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         transitionBuilder: (child, animation) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//         child: _pages[_selectedIndex],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
//           ),
//           onPressed: () {
//             if (_selectedIndex != 3) {
//               setState(() {
//                 _selectedIndex = _selectedIndex + 1;
//                 _progressValue = _progressValue + 0.1;
//                 _currentPage = _currentPage +1;
//               });
//             }
//           },
//           child: const Padding(
//             padding: EdgeInsets.symmetric(vertical: 16),
//             child: Text(
//               'Continue',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 19,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
