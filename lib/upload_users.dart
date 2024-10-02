import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future<void> uploadUsers() async {
  // Load JSON data from the file
  final String response = await rootBundle.loadString('assets/users.json');
  final List<dynamic> data = json.decode(response);

  // Get a reference to the Firestore collection
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // Upload each user to Firestore
  for (var user in data) {
    await usersCollection.add(user);
  }
  print('Data uploaded successfully!');
}
