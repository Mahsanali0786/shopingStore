import 'package:equatable/equatable.dart';
import 'package:mobilestore/core/usercase/usecase.dart';
import 'package:mobilestore/core/utils/typedef.dart';
import 'package:mobilestore/features/purchase/domain/entities/product.dart';
import 'package:mobilestore/features/purchase/domain/repositories/product_repository.dart';

class GetProdByCatUsecase extends UsecaseWithParams<List<Product>,ProdCatParam>{
  const GetProdByCatUsecase({required this.repository});
  final ProductRepository repository;
  @override
  ResultFuture<List<Product>> call(ProdCatParam params) async{

    return await repository.getAllProductsByCategory(categoryName: params.categoryName);
  }

}

class  ProdCatParam extends Equatable{

  final String categoryName;

  const ProdCatParam({required this.categoryName});

  @override
  List<Object?> get props => [categoryName];

}