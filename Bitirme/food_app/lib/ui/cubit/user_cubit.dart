import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constants/app_strings.dart';
import 'package:food_app/data/entity/user/user.dart';
import 'package:food_app/data/repo/user_dao_repository.dart';

class UserCubit extends Cubit<AppUser> {
  UserCubit() : super(AppUser(id: "", username: "", email: "", imageURL: ""));

  var uRepo = UserDaoRepository();
  var collectionUsers =
      FirebaseFirestore.instance.collection(AppStrings.firestoreName);

  Future<String?> getDocumentId(String id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await collectionUsers.where('id', isEqualTo: id).get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    } else {
      return null;
    }
  }

  Future<void> save(
      String username, String email, String id, String url) async {
    await uRepo.save(username, email, id, url);
  }

  Future<void> getUser(String email) async {
    try {
      final querySnapshot =
          await collectionUsers.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        final userKey = querySnapshot.docs.first.id;
        final user = AppUser.fromJson(userData, userKey);

        emit(user);
      }
    } catch (e) {}
  }

  Future<void> updateUsername(String username, String id) async {
    try {
      final userDocId = await getDocumentId(id);

      if (userDocId != null) {
        await uRepo.updateUsername(username, userDocId);
      }
    } catch (e) {
      // Handle errors here
      print("Error updating user: $e");
    }
  }
}
