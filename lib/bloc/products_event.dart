import 'package:equatable/equatable.dart';
import 'package:qr_code_project/data/models/product_model.dart';

sealed class ProductEvent extends Equatable {}

class AddProductEvent extends ProductEvent {
  final ProductModel productModel;

  AddProductEvent({required this.productModel});

  @override
  List<Object?> get props => [productModel];
}

class RemoveProductEvent extends ProductEvent {
  final int productId;

  RemoveProductEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class LoadProducts extends ProductEvent {
  @override
  List<Object?> get props => [];
}
