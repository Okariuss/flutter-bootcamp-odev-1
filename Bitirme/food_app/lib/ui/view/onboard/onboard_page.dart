import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/data/utils/auth_manager.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/cubit/onboard_page_cubit.dart';
import 'package:food_app/ui/view/auth/sign_in_page.dart';
import 'package:food_app/ui/view/onboard/default_slider_page.dart';

class OnboardPage extends StatefulWidget {
  final AuthManager authManager;
  const OnboardPage({
    super.key,
    required this.authManager,
  });
  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  late PageController _pageController;
  final int totalSlides = 4;
  late PreferencesService _preferencesService;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _preferencesService = PreferencesService();
    _preferencesService.init().then((_) {
      if (_preferencesService.seenOnboard) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SignInScreen(
              authManager: widget.authManager,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -width / 5,
            top: -height / 15,
            child: Container(
              width: height / 2,
              height: height / 2,
              decoration: const ShapeDecoration(
                color: AppColors.buttonColor,
                shape: OvalBorder(),
              ),
            ),
          ),
          BlocBuilder<OnboardCubit, int>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: PageView.builder(
                        itemCount: totalSlides,
                        controller: _pageController,
                        onPageChanged: (index) {
                          context.read<OnboardCubit>().emit(index);
                        },
                        itemBuilder: (context, index) {
                          return DefaultSliderPage(index: index);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          totalSlides,
                          (index) => _buildIndicator(index, state),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          final int currentPage =
                              context.read<OnboardCubit>().state;
                          if (currentPage < totalSlides - 1) {
                            // Move to the next slide
                            _pageController.animateToPage(
                              currentPage + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          } else {
                            _preferencesService.setSeenOnboard(true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(
                                  authManager: widget.authManager,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          state == 0
                              ? d.start
                              : state < totalSlides - 1
                                  ? d.next
                                  : d.sign_in,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index, int currentPage) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}
