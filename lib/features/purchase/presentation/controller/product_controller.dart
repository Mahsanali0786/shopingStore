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

  RxList<Product> searchedFavProList = <Product>[].obs;
  RxList<Product> searchedProList = <Product>[].obs;

  RxList listCategories = [].obs;
  RxList searchedCategories = [].obs;

  RxInt totalProducts = 0.obs;

  Future<void> getProducts() async {
    final result = await getAllProduct();

    result.fold(
      (l) => Exception(l.getErrorMessage),
      (r) {
        products.assignAll(r);
        totalProducts.value = products.length;
      },
    );
  }

  Future<void> searchProducts(String query,
      {required String categoryName}) async {
    List<Product> newProductList = <Product>[];

    if (categoryName.isEmpty) {
      newProductList = products
          .where((product) =>
              product.category.toLowerCase().contains(query.toLowerCase()) ||
              product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.brand.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      newProductList = products
          .where((product) =>
              product.category
                  .toLowerCase()
                  .contains(categoryName.toLowerCase()) &&
              (product.title.toLowerCase().contains(query.toLowerCase()) ||
                  product.brand.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }

    searchedProList.assignAll(newProductList);
    totalProducts.value = searchedProList.value.length;
  }

  Future<void> searchFavouriteProduct(String query) async {
    List<Product> newProductList = favouritesProductList
        .where((product) =>
            product.category.toLowerCase().contains(query.toLowerCase()) ||
            product.title.toLowerCase().contains(query.toLowerCase()) ||
            product.brand.toLowerCase().contains(query.toLowerCase()))
        .toList();

    searchedFavProList.assignAll(newProductList);
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
      }
    } catch (e) {
      throw const ApiException(
          message: 'Error while getting categories', statusCode: 500);
    }
  }

  Future<void> searchCategories(String query) async {
    searchedCategories.assignAll(listCategories
        .where(
            (category) => category.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }
}
