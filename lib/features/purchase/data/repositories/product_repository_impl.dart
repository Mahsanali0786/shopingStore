import 'package:dartz/dartz.dart';
import 'package:mobilestore/core/error/exception.dart';
import 'package:mobilestore/core/error/failure.dart';
import 'package:mobilestore/core/utils/typedef.dart';
import 'package:mobilestore/features/purchase/data/datasources/prod_remote_datasrc.dart';
import 'package:mobilestore/features/purchase/domain/entities/product.dart';
import 'package:mobilestore/features/purchase/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({required this.dataSrc});

  final ProdRemoteDataSrc dataSrc;

  @override
  ResultFuture<List<Product>> getAllProducts() async {
    try {
      final result = await dataSrc.getAllProducts();
      return Right(result);
    } on ApiException catch (e) {
      return Left(
          APIFailure(errorMessage: e.toString(), statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Product>> getAllProductsByCategory(
      {required String categoryName}) async {
    try {
      final result = await dataSrc.getProdByCat(categoryName: categoryName);
      return Right(result);
    } on ApiException catch (e) {
      return Left(
          APIFailure(errorMessage: e.toString(), statusCode: e.statusCode));
    }
  }
}
