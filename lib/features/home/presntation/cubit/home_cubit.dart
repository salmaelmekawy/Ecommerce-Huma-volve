import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_product_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presntation/view_model/home_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
final GetProductUseCase getProductUseCase;
  HomeCubit( {
  required this.getProductUseCase, 
  required this.getCategoriesUseCase,
}) : super(HomeInitial());

  void loadHomeData() async {
    int categoryId = 0;
    emit(CategoriesLoading());

    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
      },
      (categories) {
        categoryId = categories[0].id;
        emit(CategoriesSuccess(categories));
      },
    );

    final products = await getProductUseCase.invoke(categoryId);
    products.fold(
      (failure) {
        emit(ProductError(failure.failureMessage));
      },
      (productsList) {
        emit(ProductSuccess(productsList));
      },
    );
  }

  void getProductsByCategoryId(int id) async {
  emit(ProductLoading());
  
  final products = await getProductUseCase.invoke(id);
  products.fold(
    (failure) {
      emit(ProductError(failure.failureMessage));
    },
    (productsList) {
      emit(ProductSuccess(productsList));
    },
  );
}
  }
      
   
