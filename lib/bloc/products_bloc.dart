import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_project/bloc/products_event.dart';
import 'package:qr_code_project/bloc/products_state.dart';
import 'package:qr_code_project/data/models/form_status.dart';
import 'package:qr_code_project/data/models/product_model.dart';
import '../data/local/local_database.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc()
      : super(
          const ProductState(
            formStatus: FormStatus.pure,
            statusText: '',
            products: [],
          ),
        ) {
    on<LoadProducts>(_load);
    on<AddProductEvent>(_addProduct);
    on<RemoveProductEvent>(_removeProduct);
  }

  Future<void> _load(LoadProducts event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      List<ProductModel> products = await LocalDatabase.getAllProducts();
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          products: products,
        ),
      );
    } catch (e) {
      print("Error loading products: $e");
      emit(state.copyWith(formStatus: FormStatus.error, statusText: 'Error loading products'));
    }
  }

  Future<void> _addProduct(AddProductEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      ProductModel savedProduct =
          await LocalDatabase.insertProduct(event.productModel);
      List<ProductModel> updatedProducts = List.from(state.products)
        ..add(savedProduct);
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          products: updatedProducts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          formStatus: FormStatus.error, statusText: 'Error adding product'));
    }
  }

  Future<void> _removeProduct(RemoveProductEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      await LocalDatabase.deleteProduct(event.productId);
      List<ProductModel> updatedProducts = state.products
          .where((product) => product.id != event.productId)
          .toList();
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          products: updatedProducts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          formStatus: FormStatus.error, statusText: 'Error removing product'));
    }
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:qr_code_project/bloc/products_event.dart';
// import 'package:qr_code_project/bloc/products_state.dart';
// import 'package:qr_code_project/data/models/form_status.dart';
// import 'package:qr_code_project/data/models/product_model.dart';
// import 'package:qr_code_project/data/repository/product_repository.dart';
// import 'package:qr_code_project/services/service_locator.dart';
//
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   ProductBloc()
//       : super(
//           const ProductState(
//             formStatus: FormStatus.pure,
//             statusText: '',
//             products: [],
//           ),
//         ) {
//     on<LoadProducts>(_load);
//     on<AddProductEvent>(_addProduct);
//     on<RemoveProductEvent>(_removeProduct);
//   }
//
//   Future<void> _load(LoadProducts event, emit) async {
//     emit(state.copyWith(formStatus: FormStatus.loading));
//     await Future.delayed(const Duration(seconds: 1));
//     emit(
//       state.copyWith(
//         formStatus: FormStatus.success,
//         products: getIt.get<ProductRepository>().products,
//       ),
//     );
//   }
//
//   Future<void> _addProduct(AddProductEvent event, emit) async {
//     emit(state.copyWith(formStatus: FormStatus.loading));
//     await Future.delayed(const Duration(seconds: 1));
//     emit(
//       state.copyWith(
//         formStatus: FormStatus.success,
//         products: [
//           ...state.products,
//           event.productModel,
//         ],
//       ),
//     );
//   }
//
//   Future<void> _removeProduct(RemoveProductEvent event, emit) async {
//     emit(state.copyWith(formStatus: FormStatus.loading));
//     await Future.delayed(const Duration(seconds: 1));
//
//     List<ProductModel> products = state.products;
//
//     products.removeWhere((element) => element.id == event.productId);
//
//     emit(
//       state.copyWith(
//         formStatus: FormStatus.success,
//         products: products,
//       ),
//     );
//   }
// }
