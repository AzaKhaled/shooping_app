import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  Future<void> toggleTheme() async {
    final isDark = state == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    emit(newMode);
    await Prefs.setBool('isDark', newMode == ThemeMode.dark);
    print('🌙 Theme switched to: ${newMode == ThemeMode.dark}');
  }

  Future<void> loadSavedTheme() async {
    final isDark = Prefs.getBool('isDark', defaultValue: false);
    print('📦 isDark from prefs: $isDark');
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
