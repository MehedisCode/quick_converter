// screens/landing_screen.dart
import 'package:flutter/material.dart';
import 'conversion_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final List<String> categories = ['Length', 'Weight', 'Temperature'];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QuickConvert')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Convert units smartly & quickly',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select a Conversion Category',
              ),
              value: selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedCategory == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConversionScreen(
                            category: selectedCategory!,
                          ),
                        ),
                      );
                    },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
