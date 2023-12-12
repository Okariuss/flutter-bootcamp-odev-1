import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/data/entity/product/product.dart';

class UserDaoRepository {
  var collectionUsers = FirebaseFirestore.instance.collection("Users");

  Future<void> save(
      String username, String email, String id, String url) async {
    var user = HashMap<String, dynamic>();
    user["username"] = username;
    user["email"] = email;
    user["favorites"] = <Product>[];
    user["imageURL"] = url;

    // Check if the email already exists in Firestore
    QuerySnapshot<Map<String, dynamic>> emailSnapshot =
        await collectionUsers.where('email', isEqualTo: email).get();

    if (emailSnapshot.docs.isEmpty) {
      // Email doesn't exist, proceed to save the user data
      var docRef = await collectionUsers.add(user);
      var docId = id;
      await docRef.update({'id': docId});
    }
  }

  Future<bool> isUsernameTaken(String username) async {
    // Query Firestore to check if the username already exists
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await collectionUsers.where('username', isEqualTo: username).get();

    return snapshot
        .docs.isNotEmpty; // Returns true if username exists, false otherwise
  }

  Future<void> updateUsername(String username, String docId) async {
    try {
      await collectionUsers.doc(docId).update({'username': username});
    } catch (e) {
      print('Error updating username in Firestore: $e');
      // Handle error updating username in Firestore
    }
  }
}
