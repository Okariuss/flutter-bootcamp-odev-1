import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/data/utils/auth_manager.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_app_bar.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_button.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_headers.dart';
import 'package:food_app/ui/view/auth/widgets/default_auth_text_form_field.dart';

class ForgetPassword extends StatelessWidget {
  final AuthManager authManager;
  ForgetPassword({
    required this.authManager,
  });

  final _formMailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var emailTfController = TextEditingController();
    return Scaffold(
      appBar: DefaultAuthAppBar(
        title: d.forget_password,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DefaultAuthHeaders(
                title: d.forget_password,
                subtitle: d.forget_password_text,
              ),
              _buildInputFields(emailTfController, d),
              DefaultAuthButton(
                label: d.reset_password,
                onPressed: () {
                  _defaultAuthButtonOnPressed(emailTfController, context, d);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _defaultAuthButtonOnPressed(TextEditingController emailTfController,
      BuildContext context, AppLocalizations d) {
    if (_formMailKey.currentState!.validate()) {
      authManager.resetPassword(emailTfController.text, context);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                d.reset_password_sent,
              ),
              content: Text(
                d.reset_password_sent_text,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text(d.ok),
                ),
              ]);
        },
      );
    }
  }

  Widget _buildInputFields(
    TextEditingController emailTfController,
    AppLocalizations d,
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
              }),
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
}
