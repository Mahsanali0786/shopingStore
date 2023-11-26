import 'package:flutter/material.dart';
import 'package:mobilestore/core/utils/typedef.dart';
import 'package:mobilestore/features/purchase/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTapCallBack,
  });
  final Product product;
  final OnTapCallBack onTapCallBack;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTapCallBack,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              height: 200,
              width: double.infinity,
              child: Image.network(
                product.thumbnail.toString(),
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  '\$${product.price}  ',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 19),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(product.rating.toString()),
                for (int i = 1; i <= product.rating.round(); i++)
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow.shade900,
                  )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'By ${product.brand}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'In ${product.category}',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
