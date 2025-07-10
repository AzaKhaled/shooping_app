import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';

class FavoriteCubit extends Cubit<List<Product>> {
  FavoriteCubit() : super([]);

  void toggleFavorite(Product product) {
    final updatedList = List<Product>.from(state);
    final isFav = updatedList.any((item) => item.id == product.id);

    if (isFav) {
      updatedList.removeWhere((item) => item.id == product.id);
    } else {
      updatedList.add(product);
    }

    emit(updatedList);
    _saveFavoritesToPrefs(updatedList);
  }

  void _saveFavoritesToPrefs(List<Product> favorites) {
    final uid = _getUserId(); // ✅ استخدم uid
    final jsonList = favorites.map((item) => item.toJson()).toList();
    Prefs.setString('favorites_$uid', jsonEncode(jsonList));
  }

  void loadFavoritesFromPrefs() {
    final uid = _getUserId(); // ✅ استخدم uid
    final jsonString = Prefs.getString('favorites_$uid');
    if (jsonString.isNotEmpty) {
      final List decoded = jsonDecode(jsonString);
      final favorites = decoded.map((item) => Product.fromJson(item)).toList();
      emit(favorites);
    }
  }

  bool isFavorite(Product product) {
    return state.any((item) => item.id == product.id);
  }

  // ✅ دي الوظيفة الجديدة
  String _getUserId() {
    final userJson = Prefs.getString('userData');
    final userMap = jsonDecode(userJson);
    return userMap['uId'];
  }
}
