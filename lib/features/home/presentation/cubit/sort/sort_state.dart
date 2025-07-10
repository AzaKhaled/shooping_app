import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';

abstract class SortState {}

class SortInitial extends SortState {}

class SortLoading extends SortState {}

class SortSuccess extends SortState {
  final List<Product> products;

  SortSuccess(this.products);
}

class SortError extends SortState {
  final String message;

  SortError(this.message);
}
