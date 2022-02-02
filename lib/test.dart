// @dart=2.9

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firebase',
      home: AddData(),
    );
  }
}

class AddData extends StatelessWidget {
  const AddData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("geeksforgeeks"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('data')
                    .add({'text': 'Mr.meet radadiya'});
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 500,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('data').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    children: snapshot.data.docs.map((document) {
                      return Center(child: Text(document['text']));
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
