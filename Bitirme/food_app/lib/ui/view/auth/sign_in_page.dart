import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/data/utils/auth_manager.dart';
import 'package:food_app/ui/view/auth/forget_password.dart';
import 'package:food_app/ui/view/auth/widgets/auth_divider.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_google_sign.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_text_button.dart';
import 'package:food_app/ui/view/auth/sign_up_page.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_app_bar.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_button.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_headers.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_text_form_field.dart';
import 'package:food_app/ui/view/main/main_page.dart';

class SignInScreen extends StatelessWidget {
  final AuthManager authManager;
  SignInScreen({
    super.key,
    required this.authManager,
  });

  final _formMailKey = GlobalKey<FormState>();
  final _formPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var emailTfController = TextEditingController();
    var passwordTfController = TextEditingController();
    return Scaffold(
      appBar: DefaultAuthAppBar(
        title: d.sign_in,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DefaultAuthHeaders(
                  title: d.welcome_to, subtitle: d.welcome_to_text),
              _buildInputFields(
                  emailTfController, passwordTfController, d, context),
              _buildSignInButton(
                  emailTfController, passwordTfController, d, context),
              _buildNavigationButtons(context, d),
              const AuthDivider(),
              DefaultAuthGoogleSign(authManager: authManager, d: d),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields(
    TextEditingController emailTfController,
    TextEditingController passwordTfController,
    AppLocalizations d,
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: _formMailKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: DefaultAuthTextFormField(
            defaultTfController: emailTfController,
            name: d.email,
            validator: (value) {
              return _validateEmail(value, d);
            },
          ),
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
            },
          ),
        ),
        DefaultAuthTextButton(
          label: d.forget_password,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ForgetPassword(authManager: authManager)));
          },
        ),
      ],
    );
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

  Widget _buildSignInButton(
    TextEditingController emailTfController,
    TextEditingController passwordTfController,
    AppLocalizations d,
    BuildContext context,
  ) {
    return DefaultAuthButton(
      label: d.sign_in,
      onPressed: () async {
        if (_formMailKey.currentState!.validate() ||
            _formPasswordKey.currentState!.validate()) {
          User? user = await authManager.signIn(
            emailTfController.text,
            passwordTfController.text,
            context,
          );

          if (user != null) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            d.dont_have_account,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(authManager: authManager),
                ),
              );
            },
            child: Text(d.create_account),
          )
        ],
      ),
    );
  }
}
