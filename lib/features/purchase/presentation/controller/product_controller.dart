import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mobilestore/core/error/exception.dart';
import 'package:mobilestore/features/purchase/domain/entities/product.dart';
import 'package:mobilestore/features/purchase/domain/usecases/get_all_prod_usecase.dart';
import 'package:mobilestore/features/purchase/domain/usecases/get_prod_by_cat_usecase.dart';

class ProudctController extends GetxController {
  ProudctController({
    required this.getProductByCat,
    required this.getAllProduct,
  });

  final GetProdByCatUsecase getProductByCat;
  final GetAllProductsUsecase getAllProduct;

  RxList<int> favouritesIdList = <int>[].obs;
  RxList<Product> favouritesProductList = <Product>[].obs;
  RxList<Product> products = <Product>[].obs;

  RxList listCategories = [].obs;
  RxInt totalProducts = 0.obs;

  Future<void> getProducts() async {
    final result = await getAllProduct();
    result.fold(
      (l) => Exception(l.getErrorMessage),
      (r) => products.assignAll(r),
    );
    totalProducts.value = products.value.length;
  }

  Future<void> getSearchedProducts(String query) async {
    List<Product> newProductList = <Product>[];
    await getProducts();

    for (Product product in products.value) {
      if (product.category
              .toLowerCase()
              .trim()
              .contains(query.toLowerCase().trim()) ||
          product.title
              .toLowerCase()
              .trim()
              .contains(query.toLowerCase().trim()) ||
          product.brand
              .toLowerCase()
              .trim()
              .contains(query.toLowerCase().trim())) {
        newProductList.add(product);
      }
    }
    products.assignAll(newProductList);
    totalProducts.value = products.value.length;
  }

  void addRemoveFromFavList(Product product) {
    if (favouritesIdList.contains(product.id)) {
      favouritesIdList.remove(product.id);
      favouritesProductList.remove(product);
    } else {
      favouritesIdList.add(product.id);
      favouritesProductList.add(product);
    }
    favouritesIdList.refresh();
    favouritesProductList.refresh();
  }

  Future<void> getCategories() async {
    String url = 'https://dummyjson.com/products/categories';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        listCategories.assignAll(json.decode(response.body));
      } else {
      }
    } catch (e) {
      throw const ApiException(message: 'Error while getting categories', statusCode: 500);
    }
  }
}
