import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilestore/features/purchase/data/datasources/prod_remote_datasrc.dart';
import 'package:mobilestore/features/purchase/data/repositories/product_repository_impl.dart';
import 'package:mobilestore/features/purchase/domain/repositories/product_repository.dart';
import 'package:mobilestore/features/purchase/domain/usecases/get_all_prod_usecase.dart';
import 'package:mobilestore/features/purchase/domain/usecases/get_prod_by_cat_usecase.dart';
import 'package:http/http.dart' as http;

import '../../features/purchase/presentation/controller/product_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc
  sl
    ..registerFactory(
        () => ProudctController(getProductByCat: sl(), getAllProduct: sl()))

    //domain layer useCase
    ..registerLazySingleton<GetAllProductsUsecase>(
        () => GetAllProductsUsecase(repository: sl()))
    ..registerLazySingleton<GetProdByCatUsecase>(
        () => GetProdByCatUsecase(repository: sl()))

    // data layer: Repo Implementation
    ..registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(dataSrc: sl()))

    // Remote Data Src

    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton<ProdRemoteDataSrc>(
        () => ProdRemoteDataSrcImpl(client: sl()));

  Get.put(ProudctController(
      getProductByCat: sl<GetProdByCatUsecase>(),
      getAllProduct: sl<GetAllProductsUsecase>()));
}
