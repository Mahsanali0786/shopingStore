

import 'package:mobilestore/core/usercase/usecase.dart';
import 'package:mobilestore/core/utils/typedef.dart';
import 'package:mobilestore/features/purchase/domain/entities/product.dart';
import 'package:mobilestore/features/purchase/domain/repositories/product_repository.dart';

class GetAllProductsUsecase extends UsecaseWithoutParams<List<Product>>{
  const GetAllProductsUsecase({required this.repository});
  final ProductRepository repository;
  @override
  ResultFuture<List<Product>> call() async{

    return await repository.getAllProducts();
  }

}