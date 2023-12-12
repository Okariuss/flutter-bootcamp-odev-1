import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/utils/auth_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/user_cubit.dart';
import 'package:food_app/ui/view/auth/sign_in_page.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_text_form_field.dart';
import 'package:food_app/ui/view/main/main_page.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _prefs = PreferencesService();
  final authManager = AuthManager();
  var usernameTfController = TextEditingController();

  @override
  void dispose() {
    usernameTfController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    usernameTfController.text = _prefs.username;
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text("${d.profile}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _handleSignOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: _changePhoto,
              child: CircleAvatar(
                backgroundImage: NetworkImage(_prefs.imageURL),
                radius: 64,
              ),
            ),
            DefaultAuthTextFormField(
              defaultTfController: usernameTfController,
              name: d.username,
              validator: _validateName,
            ),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text("SAVE"),
            )
          ],
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value != null) {
      if (value.isEmpty || value.trim().isEmpty) {
        return 'Name cannot be empty';
      } else if (value.trim().length < 3) {
        return 'Name should be at least 3 characters without spaces';
      }
    }
    return null;
  }

  Future<void> _changePhoto() async {
    Uint8List image = await authManager.pickImage(ImageSource.gallery);
    if (image.isNotEmpty) {
      String newPhotoURL = await authManager.uploadImageToFirebaseStorage(
        image,
        _prefs.userId,
      );

      setState(() {
        _prefs.setImageURL(newPhotoURL);
      });
    }
  }

  void _handleSignOut() {
    authManager.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(authManager: authManager),
      ),
    );
  }

  void _showUsernameTakenSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Username already exists. Please choose a different one.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _saveProfile() async {
    bool updated = await _updateProfile();

    if (updated) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    }
  }

  Future<bool> _updateProfile() async {
    var currentUser = await authManager.getCurrentUser();
    bool updated = false;

    if (currentUser != null) {
      try {
        if (await authManager.isUsernameTaken(usernameTfController.text)) {
          _showUsernameTakenSnackBar();
          return false;
        }
        if (usernameTfController.text != currentUser.displayName) {
          await currentUser.updateDisplayName(usernameTfController.text);
          _prefs.setUsername(usernameTfController.text);
          updated = true;
        }
        if (_prefs.imageURL != currentUser.photoURL) {
          await currentUser.updatePhotoURL(_prefs.imageURL);
          updated = true;
        }

        if (updated) {
          // Update user in UserCubit
          await context
              .read<UserCubit>()
              .updateUsername(_prefs.username, _prefs.userId);
        }
      } catch (e) {
        print('Error updating profile: $e');
        // Handle error updating profile
        _showUsernameTakenSnackBar();
      }
    }

    return updated;
  }
}
