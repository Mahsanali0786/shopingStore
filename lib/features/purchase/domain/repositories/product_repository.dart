import 'package:mobilestore/core/utils/typedef.dart';
import 'package:mobilestore/features/purchase/domain/entities/product.dart';

abstract class ProductRepository {
  const ProductRepository();

  ResultFuture<List<Product>> getAllProducts();
  ResultFuture<List<Product>> getAllProductsByCategory({required String categoryName});
}
