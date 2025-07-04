import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/features/auth/presentation/views/singup_view.dart';
import 'package:fruits_hub/features/onboarding/presentation/views/widgets/navbar.dart';
import 'package:fruits_hub/features/onboarding/presentation/views/widgets/onboarding_view_items.dart';
class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});
  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}
class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SingUpView()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("Skip", style: TextStyles.montserrat500_12_grey)],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingViewItems(
                  imagePath: Assets.fashionShop,
                  title: 'Choose Products',
                  subtitle:
                      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
                ),
                OnboardingViewItems(
                  imagePath: Assets.salesConsulting,
                  title: 'Make Payment',
                  subtitle:
                      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
                ),
                OnboardingViewItems(
                  imagePath: Assets.shoppingBag,
                  title: 'Get Your Order',
                  subtitle:
                      'You can organize your daily tasks by adding your tasks into separate categories',
                ),
              ],
            ),
          ),
          // Buttons
          Navbar(
            controller: _controller,
            currentPage: _currentPage,
            totalPages: _totalPages,
            onNext: () {
              if (_currentPage < _totalPages - 1) {
                _controller.animateToPage(
                  _currentPage + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  _currentPage += 1;
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingUpView()),
                );
              }
            },
            onPrev: () {
              if (_currentPage > 0) {
                _controller.animateToPage(
                  _currentPage - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  _currentPage -= 1;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
