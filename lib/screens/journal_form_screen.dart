import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JournalFormScreen extends StatefulWidget {
  final Map<String, dynamic>? journalData;
  final String? docId;

  const JournalFormScreen({
    Key? key,
    this.journalData,
    this.docId,
  }) : super(key: key);

  @override
  State<JournalFormScreen> createState() => _JournalFormScreenState();
}

class _JournalFormScreenState extends State<JournalFormScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.journalData != null) {
      _titleController.text = widget.journalData!['title'];
      _contentController.text = widget.journalData!['content'];
      _selectedDate = (widget.journalData!['date'] as Timestamp).toDate();
    }
  }

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveJournal() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.docId == null) {
        // Create new journal
        await _firestore.collection('journals').add({
          'userId': _auth.currentUser!.uid,
          'title': _titleController.text.trim(),
          'content': _contentController.text.trim(),
          'date': _selectedDate,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        Fluttertoast.showToast(msg: "Journal created successfully");
      } else {
        // Update existing journal
        await _firestore.collection('journals').doc(widget.docId).update({
          'title': _titleController.text.trim(),
          'content': _contentController.text.trim(),
          'date': _selectedDate,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        Fluttertoast.showToast(msg: "Journal updated successfully");
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docId == null ? 'New Journal' : 'Edit Journal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _contentController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _saveJournal,
              child: const Text('Save Journal'),
            ),
          ],
        ),
      ),
    );
  }
}
