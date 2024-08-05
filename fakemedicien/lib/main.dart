// import 'package:flutter/foundation.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (kIsWeb) {
//     await Firebase.initializeApp(
//         options: FirebaseOptions(
//             apiKey: "AIzaSyC2olLgfKEhMkPQNOhtmligdZxvvC-8U8Y",
//             authDomain: "fakemedicine-3aca1.firebaseapp.com",
//             projectId: "fakemedicine-3aca1",
//             storageBucket: "fakemedicine-3aca1.appspot.com",
//             messagingSenderId: "876495906268",
//             appId: "1:876495906268:web:6259ae26ee63e2fe87db19",
//             measurementId: "G-L085806Y0M"));
//   }
//   runApp(const MyApp());
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import 'notifications.dart';
import 'report_screen.dart';
import 'profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set AuthScreen as the initial screen
      home: AuthScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     NotificationsScreen(),
//     ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 83, 159, 221),
//         title: const Text('Navigation App'),
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FloatingActionButton(
//         onPressed: () async {
//           try {
//             var result = await BarcodeScanner.scan();
//             if (result.rawContent.isNotEmpty) {
//               // Handle the scanned result here
//               print('Barcode result: ${result.rawContent}');
//               // Display the result in an alert dialog
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text('Scanned Barcode'),
//                     content: Text(result.rawContent),
//                     actions: <Widget>[
//                       TextButton(
//                         child: const Text('OK'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             }
//           } catch (e) {
//             // Handle any errors that occur during barcode scanning
//             print('Error: $e');
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Error'),
//                   content: const Text('Failed to scan the barcode.'),
//                   actions: <Widget>[
//                     TextButton(
//                       child: const Text('OK'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//         child: const Icon(Icons.qr_code_scanner),
//         tooltip: 'Scan Barcode',
//       ),
//     );
//   }
// }

// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: const Text('Notifications Page'),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: const Text('Profile Page'),
//     );
//   }
// }
