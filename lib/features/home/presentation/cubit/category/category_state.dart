part of 'category_cubit.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Map<String, String>> categories;

  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
