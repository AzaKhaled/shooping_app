import 'package:flutter/material.dart';
import 'package:fruits_hub/features/setting/presentation/views/widgets/setting_view_body.dart';
import 'package:fruits_hub/mainlayout/MainLayoutView.dart';

class StettingView extends StatelessWidget {
  const StettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainLayoutView()),
              (route) => false,
            );
          },
        ),
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SettingViewBody(),
    );
  }
}
