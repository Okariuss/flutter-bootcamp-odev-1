import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_app/core/theme/theme.dart';
import 'package:food_app/data/utils/auth_manager.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/firebase_options.dart';
import 'package:food_app/ui/cubit/cart_page_cubit.dart';
import 'package:food_app/ui/cubit/favorite_page_cubit.dart';
import 'package:food_app/ui/cubit/home_page_cubit.dart';
import 'package:food_app/ui/cubit/main_page_cubit.dart';
import 'package:food_app/ui/cubit/onboard_page_cubit.dart';
import 'package:food_app/ui/cubit/user_cubit.dart';
import 'package:food_app/ui/view/main/main_page.dart';
import 'package:food_app/ui/view/onboard/onboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthManager _authManager = AuthManager();
  final PreferencesService _preferencesService = PreferencesService();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => MainPageCubit(),
        ),
        BlocProvider(
          create: (context) => HomePageCubit(),
        ),
        BlocProvider(
          create: (context) => CartPageCubit(),
        ),
        BlocProvider(
          create: (context) => FavoritePageCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale("en", ""),
          Locale("tr", ""),
        ],
        theme: MyAppTheme.themeData,
        home: FutureBuilder(
          future: _authManager.getCurrentUser(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData && _preferencesService.seenOnboard) {
                return const MainPage();
              } else {
                return OnboardPage(
                  authManager: _authManager,
                );
              }
            }
          },
        ),
      ),
    );
  }
}
