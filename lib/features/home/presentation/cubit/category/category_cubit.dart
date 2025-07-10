import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/dio_service.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final DioService dioService;

  CategoryCubit(this.dioService) : super(CategoryInitial());

  Future<void> fetchCategoriesWithImages() async {
    emit(CategoryLoading());
    try {
      final categoriesWithImages = await dioService.getCategoriesWithImages();
      emit(CategoryLoaded(categoriesWithImages));
    } catch (e) {
      emit(CategoryError('Failed to load categories with images'));
    }
  }
}
