import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';

class FavoriteState {
  final List<Product> favorites;

  FavoriteState({this.favorites = const []});

  FavoriteState copyWith({List<Product>? favorites}) {
    return FavoriteState(favorites: favorites ?? this.favorites);
  }
}
