import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Main function to run the app
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BarcodeScannerScreen(), // Set the default page
    );
  }
}

// BarcodeScannerScreen with BottomNavigationBar
class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _barcode = "";
  String _scanResult = "";
  String _expiryDate = "";
  bool? _isFake;
  TextEditingController _serialNumberController = TextEditingController();

  Future<void> _scanBarcode() async {
    try {
      final result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (result != '-1') {
        setState(() {
          _barcode = result;
        });

        await FirebaseFirestore.instance.collection('barcodes').add({
          'barcode': _barcode,
          'scannedAt': Timestamp.now(),
        });

        await _checkMedicine(_barcode);
      }
    } catch (e) {
      setState(() {
        _barcode = 'Error: $e';
      });
    }
  }

  Future<void> _checkMedicine(String barcode) async {
    try {
      final url = 'https://your-api-endpoint.com/check-medicine';
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({'barcode': barcode}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _isFake = data['isFake'];
          _expiryDate = "Expiry Date: ${data['expiryDate']}";
          _scanResult =
              _isFake! ? "This medicine is fake." : "This medicine is genuine.";
        });
      } else {
        setState(() {
          _scanResult = "Failed to check medicine. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        _scanResult = 'Error connecting to API: $e';
      });
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationsPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReportPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search for Medicine',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),
            // Serial number input
            Container(
              width: double.infinity,
              child: TextField(
                controller: _serialNumberController,
                decoration: InputDecoration(
                  labelText: 'Enter Serial Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Barcode scanner button
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Scan Barcode'),
            ),
            SizedBox(height: 20),
            // Display scanned barcode or serial number
            Text(
              _barcode.isEmpty
                  ? 'Awaiting scan or serial input...'
                  : 'Scanned: $_barcode',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Display scan result
            Text(
              _scanResult.isEmpty ? 'Awaiting result...' : _scanResult,
              style: TextStyle(
                fontSize: 20,
                color: _isFake == true ? Colors.red : Colors.green,
              ),
            ),
            SizedBox(height: 10),
            // Display expiry date if available
            if (_expiryDate.isNotEmpty)
              Text(
                _expiryDate,
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, // Call _onItemTapped when an item is tapped
      ),
    );
  }
}

// Home page widget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}

// Notifications page widget
class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Page'),
      ),
      body: Center(
        child: Text('Notifications Page Content'),
      ),
    );
  }
}

// Report page widget
class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Page'),
      ),
      body: Center(
        child: Text('Report Page Content'),
      ),
    );
  }
}

// Profile page widget
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Text('Profile Page Content'),
      ),
    );
  }
}
