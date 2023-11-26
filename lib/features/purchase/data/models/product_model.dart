import 'dart:convert';

import 'package:mobilestore/features/purchase/domain/entities/product.dart';

import '../../../../core/utils/typedef.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.price,
      required super.discountPercentage,
      required super.rating,
      required super.stock,
      required super.brand,
      required super.category,
      required super.thumbnail,
      required super.images});

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(jsonDecode(source) as DataMap);

  ProductModel.fromMap(DataMap map)
      : this(
            id: map['id'] as int,
            title: map['title'] as String,
            description: map['description'] as String,
            price: map['price'] as int,
            discountPercentage: map['discountPercentage'] as double,
            rating:  (map['rating'] is int) ? (map['rating'] as int).toDouble() : map['rating'] as double,
            stock: map['stock'] as int,
            brand: map['brand'] as String,
            category: map['category'] as String,
            thumbnail: map['thumbnail'],
            images: map['images'] as List);
}
