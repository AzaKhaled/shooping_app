import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_cubit.dart';

class SortCubit extends Cubit<String> {
  final ProductCubit productCubit;
  String currentOrder = 'asc';

  SortCubit(this.productCubit) : super('asc') {
    productCubit.fetchProducts(order: currentOrder);
  }

  void toggleSort() {
    currentOrder = (currentOrder == 'asc') ? 'desc' : 'asc';
    emit(currentOrder);
    productCubit.fetchProducts(order: currentOrder);
  }
}
