import '../models/product_model.dart';

class ProductRepository {
  final List<ProductModel> products = [
    ProductModel(
      id: 1,
      name: "Olma",
      description: "Mazali yashil olma",
      qrCode: "jshdTfghvgfYGdf",
      dateTime: DateTime.now().toString(),
    ),
    ProductModel(
      id: 2,
      name: "olcha",
      description: "Mazali qizil olcha",
      qrCode: "jshdTfghsdfkdasvgfYGdf",
      dateTime: DateTime.now().toString(),
    ),
  ];
}
