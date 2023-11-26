import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestore/core/utils/typedef.dart';
import 'package:mobilestore/features/purchase/domain/entities/product.dart';
import 'package:mobilestore/features/purchase/presentation/views/product_details.dart';

class FavCard extends StatelessWidget {
  const FavCard({
    super.key,
    required this.product,
    required this.onPressedCallBack,
  });

  final Product product;
  final OnTapCallBack onPressedCallBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetails(product: product));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.fill,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(product.rating.toString(),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        for (int i = 1; i <= 4; i++)
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.yellow.shade900,
                            ),
                          )
                      ],
                    ),
                  ],
                )
              ],
            ),
            IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                iconSize: 30,
                onPressed: onPressedCallBack),
          ],
        ),
      ),
    );
  }
}
