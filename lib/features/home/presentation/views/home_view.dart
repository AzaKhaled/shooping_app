import 'package:flutter/material.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: HomeViewBody()));
  }
}
