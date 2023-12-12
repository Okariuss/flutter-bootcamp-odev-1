import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/data/entity/product/product.dart';

class UserDaoRepository {
  var collectionUsers = FirebaseFirestore.instance.collection("Users");

  Future<void> save(
      String username, String email, String id, String url) async {
    var user = HashMap<String, dynamic>();
    var usernameChanged = username.toLowerCase().replaceAll(" ", "_");

    user["username"] = usernameChanged;
    user["email"] = email;
    user["favorites"] = <Product>[];
    user["imageURL"] = url;

    QuerySnapshot<Map<String, dynamic>> emailSnapshot =
        await collectionUsers.where('email', isEqualTo: email).get();

    if (emailSnapshot.docs.isEmpty) {
      var docRef = await collectionUsers.add(user);
      var docId = id;
      await docRef.update({'id': docId});
    }
  }

  Future<bool> isUsernameTaken(String username) async {
    var usernameChanged = username.toLowerCase().replaceAll(" ", "_");
    QuerySnapshot<Map<String, dynamic>> snapshot = await collectionUsers
        .where('username', isEqualTo: usernameChanged)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> updateUsername(String username, String docId) async {
    try {
      var usernameChanged = username.toLowerCase().replaceAll(" ", "_");

      await collectionUsers.doc(docId).update({'username': usernameChanged});
    } catch (e) {
      print('Error updating username in Firestore: $e');
    }
  }
}
