import 'package:equatable/equatable.dart';
import 'package:fruits_hub/features/addtocard/data/repo/models/cart_model.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;

  const CartState({this.cartItems = const []});

  CartState copyWith({List<CartItem>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }

  @override
  List<Object> get props => [cartItems];
}
