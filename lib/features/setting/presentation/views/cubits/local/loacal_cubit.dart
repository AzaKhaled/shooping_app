import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    loadSavedLocale();
  }

  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('locale') ?? 'en';
    emit(Locale(code));
  }

  Future<void> toggleLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final isArabic = state.languageCode == 'ar';
    final newLocale = isArabic ? const Locale('en') : const Locale('ar');
    await prefs.setString('locale', newLocale.languageCode);
    emit(newLocale);
  }
}
