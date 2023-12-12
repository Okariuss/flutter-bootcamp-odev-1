import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/core/constants/app_strings.dart';
import 'package:food_app/data/utils/auth_manager.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/user_cubit.dart';
import 'package:food_app/ui/view/auth/widgets/auth_divider.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_app_bar.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_button.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_google_sign.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_headers.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_text_button.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_text_form_field.dart';
import 'package:food_app/ui/view/main/main_page.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  final AuthManager authManager;
  SignUpPage({
    super.key,
    required this.authManager,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formNameKey = GlobalKey<FormState>();

  final _formMailKey = GlobalKey<FormState>();

  final _formPasswordKey = GlobalKey<FormState>();

  final _formConfirmKey = GlobalKey<FormState>();

  Uint8List? _image;

  final _prefs = PreferencesService();

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var usernameTfController = TextEditingController();
    var emailTfController = TextEditingController();
    var passwordTfController = TextEditingController();
    var confirmPasswordTfController = TextEditingController();
    return Scaffold(
      appBar: DefaultAuthAppBar(
        title: d.sign_up,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DefaultAuthHeaders(
                title: d.create_account,
                subtitle: d.create_account_text,
              ),
              _signUpImage(),
              _buildInputFields(
                usernameTfController,
                emailTfController,
                passwordTfController,
                confirmPasswordTfController,
                d,
              ),
              _buildSignUpButton(usernameTfController, emailTfController,
                  passwordTfController, d, context),
              _buildNavigationButtons(context, d),
              const AuthDivider(),
              DefaultAuthGoogleSign(
                authManager: widget.authManager,
                d: d,
              )
            ],
          ),
        ),
      ),
    );
  }

  Center _signUpImage() {
    return Center(
      child: GestureDetector(
        onTap: selectImage,
        child: _image != null
            ? CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(_image!),
              )
            : CircleAvatar(
                radius: 64,
                child: Image.network(AppStrings.defaultImage),
              ),
      ),
    );
  }

  void selectImage() async {
    Uint8List img = await widget.authManager.pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Widget _buildInputFields(
    TextEditingController usernameTfController,
    TextEditingController emailTfController,
    TextEditingController passwordTfController,
    TextEditingController confirmPasswordTfController,
    AppLocalizations d,
  ) {
    return Column(
      children: [
        Form(
          key: _formNameKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: DefaultAuthTextFormField(
              defaultTfController: usernameTfController,
              name: d.username,
              validator: (value) {
                return _validateName(value, d);
              }),
        ),
        Form(
          key: _formMailKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: DefaultAuthTextFormField(
              defaultTfController: emailTfController,
              name: d.email,
              validator: (value) {
                return _validateEmail(value, d);
              }),
        ),
        Form(
          key: _formPasswordKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: DefaultAuthTextFormField(
              defaultTfController: passwordTfController,
              name: d.password,
              obscureText: true,
              validator: (value) {
                return _validatePassword(value, d);
              }),
        ),
        Form(
          key: _formConfirmKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: DefaultAuthTextFormField(
            defaultTfController: confirmPasswordTfController,
            name: d.confirm_passowrd,
            obscureText: true,
            validator: (value) {
              return _validateConfirmPassword(
                  value, passwordTfController.text, d);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(
    TextEditingController usernameTfController,
    TextEditingController emailTfController,
    TextEditingController passwordTfController,
    AppLocalizations d,
    BuildContext context,
  ) {
    return DefaultAuthButton(
      label: d.sign_up,
      onPressed: () async {
        if (_formNameKey.currentState!.validate() ||
            _formMailKey.currentState!.validate() ||
            _formPasswordKey.currentState!.validate() ||
            _formConfirmKey.currentState!.validate()) {
          if (_image == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(d.select_image),
                duration: const Duration(seconds: 2),
              ),
            );
            return;
          }
          User? user = await widget.authManager.signUp(
              emailTfController.text,
              passwordTfController.text,
              usernameTfController.text,
              _image!,
              context,
              d);
          if (user != null) {
            context.read<UserCubit>().save(usernameTfController.text,
                emailTfController.text, user.uid, _prefs.imageURL);
            // ignore: use_build_context_synchronously
            if (Navigator.canPop(context)) {
              // ignore: use_build_context_synchronously
              Navigator.popUntil(context, (route) => route.isFirst);
            }
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildNavigationButtons(BuildContext context, AppLocalizations d) {
    return DefaultAuthTextButton(
      label: d.already_have_account,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String? _validateName(String? value, AppLocalizations d) {
    if (value != null) {
      if (value.isEmpty || value.trim().isEmpty) {
        return d.name_cannot_empty;
      } else if (value.trim().length < 3) {
        return d.name_cannot_empty_text;
      }
    }
    return null;
  }

  String? _validateEmail(String? value, AppLocalizations d) {
    if (value != null) {
      final emailRegex = RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Regular expression for email validation
      if (!emailRegex.hasMatch(value)) {
        return d.invalid_email_format;
      }
    }
    return null;
  }

  String? _validatePassword(String? value, AppLocalizations d) {
    if (value != null) {
      if (value.isEmpty) {
        return d.password_cannot_empty;
      } else if (value.length < 6) {
        return d.password_length_text;
      }
    }
    return null;
  }

  String? _validateConfirmPassword(
      String? value, String password, AppLocalizations d) {
    if (value != password) {
      return d.passwords_do_not_match;
    }
    return null;
  }
}
