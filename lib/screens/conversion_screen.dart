// screens/conversion_screen.dart
import 'package:flutter/material.dart';
import 'package:quick_converter/screens/history_screen.dart';
import '../utils/conversion_formulas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversionScreen extends StatefulWidget {
  final String category;

  const ConversionScreen({Key? key, required this.category}) : super(key: key);

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final TextEditingController _valueController = TextEditingController();
  String? fromUnit;
  String? toUnit;
  String result = '';

  late List<String> units;

  @override
  void initState() {
    super.initState();
    units = getUnitsForCategory(widget.category);
    fromUnit = units.first;
    toUnit = units.last;
  }

  void convert() {
    final input = double.tryParse(_valueController.text);
    if (input == null) {
      setState(() {
        result = 'Invalid input';
      });
      return;
    }

    final convertedValue = performConversion(
      category: widget.category,
      value: input,
      fromUnit: fromUnit!,
      toUnit: toUnit!,
    );

    setState(() {
      result =
          '$input $fromUnit = ${convertedValue.toStringAsFixed(4)} $toUnit';
    });

    FirebaseFirestore.instance.collection('history').add({
      'category': widget.category,
      'input': input,
      'from': fromUnit,
      'to': toUnit,
      'output': convertedValue,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.category} Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromUnit,
                    decoration: InputDecoration(labelText: 'Convert from'),
                    items: units.map((String unit) {
                      return DropdownMenuItem(value: unit, child: Text(unit));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        fromUnit = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toUnit,
                    decoration: InputDecoration(labelText: 'Convert to'),
                    items: units.map((String unit) {
                      return DropdownMenuItem(value: unit, child: Text(unit));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        toUnit = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.history),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryScreen()),
          );
        },
      ),
    );
  }
}
