import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilestore/core/error/exception.dart';
import 'package:mobilestore/core/utils/constants.dart';
import 'package:mobilestore/core/utils/typedef.dart';
import 'package:mobilestore/features/purchase/data/models/product_model.dart';

abstract class ProdRemoteDataSrc {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProdByCat({required String categoryName});
}

const kProducts = '/products/';
const kGetUsers = '/products/';

class ProdRemoteDataSrcImpl implements ProdRemoteDataSrc {
  const ProdRemoteDataSrcImpl({required this.client});
  final http.Client client;
  @override
  Future<List<ProductModel>> getAllProducts() async {
    int limit = 100;
    try {
      final Uri uri =
          Uri.parse('https://dummyjson.com/products?limit=${limit}');
      final response = await client.get(uri);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: 'Failed to Get User',
          statusCode: response.statusCode,
        );
      } else {
        final productData = jsonDecode(response.body);
        List<ProductModel> productList = [];
        if (productData != null && productData.containsKey('products')) {
          List products = productData['products'];
          for (var element in products) {
            DataMap productMap = element as DataMap;
            productList.add(ProductModel.fromMap(productMap));
          }
        } else {
          throw const ApiException(message: 'No data found', statusCode: 500);
        }

        return productList;
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ProductModel>> getProdByCat(
      {required String categoryName}) async {
    try {
      final response = await client.get(Uri.parse('$kBaseUrl$kProducts'));
      if (response.statusCode != 200 || response.statusCode != 201) {
        throw ApiException(
            message: 'Failed to Get User', statusCode: response.statusCode);
      } else {
        final productData = jsonDecode(response.body) as List;
        List<ProductModel> productList = [];
        if (productData != null) {
          for (var element in productData) {
            DataMap productMap = element as DataMap;
            ProductModel product = ProductModel.fromMap(productMap);
            if (product.category == categoryName) {
              productList.add(product);
            }
          }
        }
        return productList;
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
