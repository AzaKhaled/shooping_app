import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/features/addtocard/data/repo/models/cart_model.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_state.dart';
import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void addToCart(Product product) {
    final List<CartItem> updatedItems = List.from(state.cartItems);
    final index = updatedItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      updatedItems[index].quantity += 1;
    } else {
      updatedItems.add(CartItem(product: product));
    }

    emit(state.copyWith(cartItems: updatedItems));
    _saveCartToPrefs(); // ✅
  }

  void removeFromCart(Product product) {
    final updatedItems = List<CartItem>.from(state.cartItems)
      ..removeWhere((item) => item.product.id == product.id);
    emit(state.copyWith(cartItems: updatedItems));
    _saveCartToPrefs(); // ✅
  }

  double get totalPrice => state.cartItems.fold(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );

  void _saveCartToPrefs() {
    final uid = _getUserId(); // ✅ استخدم uid
    final jsonList = state.cartItems.map((item) => item.toJson()).toList();
    Prefs.setString('cart_$uid', jsonEncode(jsonList));
  }

  Future<void> loadCartFromPrefs() async {
    final uid = _getUserId(); // ✅ استخدم uid
    final cartString = Prefs.getString('cart_$uid');
    if (cartString.isEmpty) return;

    final List decoded = jsonDecode(cartString);
    final cartItems = decoded.map((item) => CartItem.fromJson(item)).toList();
    emit(state.copyWith(cartItems: cartItems));
  }

  String _getUserId() {
    final userJson = Prefs.getString('userData');
    final userMap = jsonDecode(userJson);
    return userMap['uId'];
  }
}
