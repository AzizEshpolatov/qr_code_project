import 'package:equatable/equatable.dart';
import '../data/models/form_status.dart';
import '../data/models/product_model.dart';

class ProductState extends Equatable {
  final FormStatus formStatus;
  final String statusText;
  final List<ProductModel> products;

  const ProductState({
    required this.formStatus,
    required this.statusText,
    required this.products,
  });

  ProductState copyWith({
    FormStatus? formStatus,
    String? statusText,
    List<ProductModel>? products,
  }) =>
      ProductState(
        formStatus: formStatus ?? this.formStatus,
        statusText: statusText ?? this.statusText,
        products: products ?? this.products,
      );

  @override
  List<Object?> get props => [
        formStatus,
        statusText,
        products,
      ];
}
