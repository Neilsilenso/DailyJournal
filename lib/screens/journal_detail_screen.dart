import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'journal_form_screen.dart';

class JournalDetailScreen extends StatelessWidget {
  final Map<String, dynamic> doc;
  final String docId;

  const JournalDetailScreen({
    Key? key,
    required this.doc,
    required this.docId,
  }) : super(key: key);

  void _deleteJournal(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Journal'),
          content: const Text('Are you sure you want to delete this journal?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance.collection('journals').doc(docId).delete();
                  Fluttertoast.showToast(msg: "Journal deleted");
                  if (context.mounted) {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Return to home
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: "Error: ${e.toString()}");
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var date = (doc['date'] as Timestamp).toDate();
    var formattedDate = DateFormat('dd MMM yyyy').format(date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JournalFormScreen(
                    journalData: doc,
                    docId: docId,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteJournal(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doc['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(formattedDate, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            Text(doc['content']),
          ],
        ),
      ),
    );
  }
}
