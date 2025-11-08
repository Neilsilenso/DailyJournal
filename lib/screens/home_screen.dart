import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'journal_form_screen.dart';
import 'journal_detail_screen.dart';
import 'about_screen.dart';
import 'splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//
//   void _logout() {
//     _auth.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const SplashScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ----------------------
//       // Gradient Header AppBar
//       // ----------------------
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text(
//           'My Journal',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         actions: [
//           PopupMenuButton(
//             color: Colors.white,
//             itemBuilder: (BuildContext context) => [
//               PopupMenuItem(
//                 child: const Text('About'),
//                 onTap: () {
//                   Future.delayed(Duration.zero, () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const AboutScreen()),
//                     );
//                   });
//                 },
//               ),
//               PopupMenuItem(
//                 child: const Text('Logout'),
//                 onTap: _logout,
//               ),
//             ],
//           ),
//         ],
//       ),
//
//       body: Stack(
//         children: [
//           // ----------------------
//           // Background Gradient
//           // ----------------------
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//
//           // ----------------------
//           // Content
//           // ----------------------
//           Padding(
//             padding: const EdgeInsets.only(top: 100),
//             child: StreamBuilder(
//               stream: _firestore
//                   .collection('journals')
//                   .where('userId', isEqualTo: _auth.currentUser!.uid)
//                   .orderBy('date', descending: true)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 if (snapshot.data!.docs.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       'No journal entries yet',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   );
//                 }
//
//                 return ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var doc = snapshot.data!.docs[index];
//                     var date = (doc['date'] as Timestamp).toDate();
//                     var formattedDate = DateFormat('dd MMM yyyy').format(date);
//
//                     return Container(
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(14),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.08),
//                             blurRadius: 8,
//                             spreadRadius: 1,
//                           ),
//                         ],
//                       ),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         title: Text(
//                           doc['title'],
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         subtitle: Text(
//                           "$formattedDate\n${doc['content'].substring(0, 30)}...",
//                           style:
//                           const TextStyle(height: 1.4, color: Colors.black54),
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => JournalDetailScreen(
//                                 doc: doc.data() as Map<String, dynamic>,
//                                 docId: doc.id,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//
//       // ----------------------
//       // Modern Floating Button
//       // ----------------------
//       floatingActionButton: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50),
//           gradient: const LinearGradient(
//             colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//           ),
//         ),
//         child: FloatingActionButton(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const JournalFormScreen()),
//             );
//           },
//           child: const Icon(Icons.add, size: 30),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy journal data (UI only)
  final List<Map<String, String>> journals = [
    {
      "title": "A Peaceful Day",
      "date": "12 Nov 2025",
      "content": "Today I enjoyed a beautiful sunset at the beach..."
    },
    {
      "title": "My College Project",
      "date": "10 Nov 2025",
      "content": "Working on a Flutter project and it is coming out great..."
    },
  ];

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // ----------------------
      // Modern Gradient AppBar
      // ----------------------
      appBar: AppBar(
        title: const Text(
          'My Journal',
          style: TextStyle(fontWeight: FontWeight.bold,  color: Colors.white,),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('About'),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()),
                    );
                  });
                },
              ),
              PopupMenuItem(
                child: const Text('Logout'),
                onTap: _logout,
              ),
            ],
          ),
        ],
      ),

      body: Stack(
        children: [
          // ----------------------
          // Background Gradient
          // ----------------------
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ----------------------
          // Content List
          // ----------------------
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: journals.isEmpty
                ? const Center(
              child: Text(
                "No journal entries yet",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: journals.length,
              itemBuilder: (context, index) {
                final item = journals[index];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,

                    // Title
                    title: Text(
                      item["title"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    // Date + preview
                    subtitle: Text(
                      "${item["date"]}\n${item["content"]!.substring(0, 30)}...",
                      style: const TextStyle(
                        height: 1.4,
                        color: Colors.black54,
                      ),
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JournalDetailScreen(
                            title: item["title"]!,
                            date: item["date"]!,
                            content: item["content"]!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ----------------------
      // Modern FAB
      // ----------------------
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          ),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const JournalFormScreen()),
            );
          },
          child: const Icon(Icons.add, size: 30,  color: Colors.white,),
        ),
      ),
    );
  }
}
