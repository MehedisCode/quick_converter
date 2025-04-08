// screens/history_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conversion History')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('history')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
            return Center(child: Text('No conversion history found.'));

          final history = snapshot.data!.docs;

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final data = history[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  '${data['input']} ${data['from']} → ${data['to']}',
                ),
                subtitle: Text(
                  'Result: ${data['output']} (${data['category']})',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
