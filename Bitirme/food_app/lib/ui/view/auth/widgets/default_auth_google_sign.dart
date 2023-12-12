import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/core/constants/app_images.dart';
import 'package:food_app/data/utils/auth_manager.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/user_cubit.dart';
import 'package:food_app/ui/view/main/main_page.dart';

class DefaultAuthGoogleSign extends StatelessWidget {
  DefaultAuthGoogleSign({
    super.key,
    required this.authManager,
    required this.d,
  });

  final AuthManager authManager;
  final AppLocalizations d;

  final _prefs = PreferencesService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            d.or,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: () async {
            User? user = await authManager.signInWithGoogle();
            if (user != null) {
              // ignore: use_build_context_synchronously
              context.read<UserCubit>().save(
                  user.displayName!, user.email!, user.uid, _prefs.imageURL);

              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              // Google sign-in successful, navigate to the main page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            } else {
              // Google sign-in failed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(d.google_sign_fail),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.googleIcon),
              Text(d.connect_with_google),
              const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}
