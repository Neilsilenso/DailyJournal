import 'package:daily_journal_app/screens/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'journal_form_screen.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class JournalDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> doc;
//   final String docId;
//
//   const JournalDetailScreen({
//     Key? key,
//     required this.doc,
//     required this.docId,
//   }) : super(key: key);
//
//   void _deleteJournal(BuildContext context) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'Delete Journal',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           content: const Text(
//             'Are you sure you want to delete this journal?',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red.shade600,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//               onPressed: () async {
//                 try {
//                   await FirebaseFirestore.instance
//                       .collection('journals')
//                       .doc(docId)
//                       .delete();
//
//                   Fluttertoast.showToast(msg: "Journal deleted");
//
//                   if (context.mounted) {
//                     Navigator.pop(context);
//                     Navigator.pop(context);
//                   }
//                 } catch (e) {
//                   Fluttertoast.showToast(msg: "Error: $e");
//                 }
//               },
//               child: const Text('Delete',
//                   style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var date = (doc['date'] as Timestamp).toDate();
//     var formattedDate = DateFormat('dd MMM yyyy').format(date);
//
//     return Scaffold(
//       // Gradient AppBar
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text(
//           'Journal Detail',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             tooltip: "Edit",
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => JournalFormScreen(
//                     journalData: doc,
//                     docId: docId,
//                   ),
//                 ),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete),
//             tooltip: "Delete",
//             onPressed: () => _deleteJournal(context),
//           ),
//         ],
//       ),
//
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//
//           // Content card
//           Padding(
//             padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
//             child: Container(
//               padding: const EdgeInsets.all(22),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.12),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title
//                     Text(
//                       doc['title'],
//                       style: const TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         height: 1.3,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//
//                     // Date
//                     Row(
//                       children: [
//                         Icon(Icons.calendar_today,
//                             size: 18, color: Colors.grey.shade600),
//                         const SizedBox(width: 6),
//                         Text(
//                           formattedDate,
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 18),
//
//                     // Divider
//                     Divider(color: Colors.grey.shade300),
//
//                     const SizedBox(height: 16),
//
//                     // Content
//                     Text(
//                       doc['content'],
//                       style: const TextStyle(
//                         fontSize: 17,
//                         height: 1.5,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class JournalDetailScreen extends StatelessWidget {
  final String title;
  final String date;
  final String content;

  const JournalDetailScreen({
    Key? key,
    required this.title,
    required this.date,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // ---------------------------
      // Modern Gradient AppBar
      // ---------------------------
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Journal Detail",
          style: TextStyle(fontWeight: FontWeight.bold,  color: Colors.white,),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit,  color: Colors.white,),
            tooltip: "Edit",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete,  color: Colors.white,),
            tooltip: "Delete",
            onPressed: () {},
          ),
        ],
      ),

      body: Stack(
        children: [
          // ---------------------------
          // Background Gradient
          // ---------------------------
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ---------------------------
          // Journal Content Container
          // ---------------------------
          Padding(
            padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------------------
                    // Title
                    // ---------------------------
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ---------------------------
                    // Date
                    // ---------------------------
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 18, color: Colors.grey.shade600),
                        const SizedBox(width: 6),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    Divider(color: Colors.grey.shade300),
                    const SizedBox(height: 16),

                    // ---------------------------
                    // Content Text
                    // ---------------------------
                    Text(
                      content,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
