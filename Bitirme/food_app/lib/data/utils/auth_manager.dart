import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constants/app_strings.dart';
import 'package:food_app/data/repo/user_dao_repository.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/user_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _prefs = PreferencesService();

  Future<User?> signUp(String email, String password, String username,
      Uint8List image, BuildContext context, AppLocalizations d) async {
    try {
      var savedUsername = username.toLowerCase().replaceAll(" ", "_");
      bool isUsernameTakenUse = await isUsernameTaken(savedUsername);

      if (isUsernameTakenUse) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(d.usernameExist),
            duration: const Duration(seconds: 2),
          ),
        );
        return null;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String imageURL =
          await uploadImageToFirebaseStorage(image, userCredential.user!.uid);
      if (userCredential.user != null) {
        await _prefs.setUsername(username);
        await _prefs.setEmail(email);
        await _prefs.setUserId(userCredential.user!.uid);
        await _prefs.setImageURL(imageURL);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.message?.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future<User?> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        var username = await _getUsername(email, context.read<UserCubit>());
        String imageURL =
            await getImageURLFromFirebase(userCredential.user!.uid);
        await _prefs.setUsername(username);
        await _prefs.setEmail(email);
        await _prefs.setUserId(userCredential.user!.uid);
        await _prefs.setImageURL(imageURL);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.message?.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
      return null;
    }
  }

  Future<void> updateUsernameInFirestore(String username, String id) async {
    try {
      var userDocId = await getUserDocId(id);
      if (userDocId != null) {
        var userDao = UserDaoRepository();
        await userDao.updateUsername(username, userDocId);
      }
    } catch (e) {
      // print('Error updating username in Firestore: $e');
    }
  }

  Future<String?> getUserDocId(String id) async {
    var collection =
        FirebaseFirestore.instance.collection(AppStrings.firestoreName);

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await collection.where('id', isEqualTo: id).get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    } else {
      return null;
    }
  }

  Future<bool> isUsernameTaken(String username) async {
    return await UserDaoRepository().isUsernameTaken(username);
  }

  Future<String> _getUsername(String email, UserCubit cubit) async {
    await cubit.getUser(email);
    return cubit.state.username;
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var userCredential = await _auth.signInWithCredential(credential);

    if (userCredential.user != null) {
      await _prefs.setUsername(userCredential.user!.displayName ?? '');
      await _prefs.setEmail(userCredential.user!.email!);
      await _prefs.setUserId(userCredential.user!.uid);
      await _prefs.setImageURL(userCredential.user!.photoURL!);
    }
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _prefs.setUsername('');
    await _prefs.setEmail('');
    await _prefs.setUserId('');
    await _prefs.setImageURL('');
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.message?.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    return Uint8List(0);
  }

  Future<String> uploadImageToFirebaseStorage(
      Uint8List imgBytes, String userId) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('${AppStrings.storageName}/$userId');
      UploadTask uploadTask = storageReference.putData(imgBytes);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      // print("Error uploading image: $e");
      return '';
    }
  }

  Future<String> getImageURLFromFirebase(String userId) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('user_images/$userId');
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return '';
    }
  }
}
