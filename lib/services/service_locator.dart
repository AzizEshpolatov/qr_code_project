import 'package:get_it/get_it.dart';
import 'package:qr_code_project/data/repository/product_repository.dart';

var getIt = GetIt.I;

void setUp() {
  getIt.registerSingleton<ProductRepository>(ProductRepository());
}
