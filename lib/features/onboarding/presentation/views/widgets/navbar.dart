import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Navbar extends StatelessWidget {
  final PageController controller;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const Navbar({
    super.key,
    required this.controller,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر Prev أو فراغ
          currentPage > 0
              ? TextButton(
                  onPressed: onPrev,
                  child: Text(
                    'Prev',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                )
              : const SizedBox(width: 60),

          // 🟠 Indicator في النص
          SmoothPageIndicator(
            controller: controller,
            count: totalPages,
            effect: WormEffect(
              dotColor: Colors.grey.shade400,
              activeDotColor: Colors.redAccent,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),

          // زر Next أو Get Started
          TextButton(
            onPressed: onNext,
            child: Text(
              currentPage == totalPages - 1 ? 'Get Started' : 'Next',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
