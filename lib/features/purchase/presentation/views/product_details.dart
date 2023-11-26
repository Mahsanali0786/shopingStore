import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestore/features/purchase/domain/entities/product.dart';
import 'package:mobilestore/features/purchase/presentation/controller/product_controller.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    ProudctController proudctController = Get.find<ProudctController>();
    // bool isLiked = proudctController.favouritesLi.value.contains(product.id);
    // print(isLiked);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          iconSize: 25,
          onPressed: () {
            Get.back();
          },
        ),
        toolbarHeight: 70,
        title: const Text(
          'Products',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'playfair',
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 3.5,
              width: MediaQuery.sizeOf(context).width,
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Product Details:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Obx(
                        () => IconButton(
                            icon: Icon(proudctController.favouritesIdList.value
                                    .contains(product.id)
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined),
                            color: proudctController.favouritesIdList.value
                                    .contains(product.id)
                                ? Colors.red
                                : Colors.black,
                            iconSize: 30,
                            onPressed: () {
                              proudctController.addRemoveFromFavList(product);
                            }),
                      ),
                    ],
                  ),
                  InlineText('Date', product.title),
                  InlineText('Price', product.price.toString()),
                  InlineText('Category', product.category),
                  InlineText('Brand', product.brand),
                  Row(
                    children: [
                      InlineText('Rating', product.rating.toString()),
                      for (int i = 1; i <= product.rating.round(); i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, left: 2),
                          child: Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow.shade900,
                          ),
                        )
                    ],
                  ),
                  InlineText('Stock', product.stock.toString()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InlineText('Description', ''),
                      Text(product.description)
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 500,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Gallery',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: product.images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 120,
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 10),
                        itemBuilder: (context, index) => Container(
                              color: Colors.red,
                              child: Image.network(
                                product.images[index],
                                fit: BoxFit.cover,
                              ),
                            )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InlineText extends StatelessWidget {
  const InlineText(
    this.type,
    this.value, {
    super.key,
  });
  final String type;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$type:  ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(value, style: const TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}
