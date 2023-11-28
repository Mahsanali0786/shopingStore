import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestore/features/purchase/data/datasources/prod_remote_datasrc.dart';
import 'package:mobilestore/features/purchase/presentation/controller/product_controller.dart';
import 'package:mobilestore/features/purchase/presentation/views/product_details.dart';
import 'package:mobilestore/features/purchase/presentation/widgets/product_card.dart';
import 'package:mobilestore/features/purchase/presentation/widgets/search_bar.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    super.key,
    this.isLeading = false,
    this.isCategory = false,
    required this.nameOfScreen,
  });
  bool isLeading;
  bool isCategory;
  final String nameOfScreen;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late TextEditingController searchController;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProudctController productController = Get.find<ProudctController>();
    if (widget.isCategory == true && widget.nameOfScreen != '') {
      productController.searchProducts(widget.nameOfScreen.toString(),
          categoryName: '');
      setState(() {
        isSearching = true;
      });
    } else {
      productController.getProducts();
    }
    return Scaffold(
      appBar: AppBar(
        leading: widget.isLeading
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                color: Colors.black,
                iconSize: 25,
                onPressed: () {
                  Get.back();
                },
              )
            : Container(),
        toolbarHeight: 70,
        title: Text(
          widget.nameOfScreen,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'playfair',
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              searchFieldController: searchController,
              onChangeCallBack: (String query) {
                setState(() {
                  isSearching = true;
                });
                if (widget.isCategory) {
                  productController.searchProducts(query,
                      categoryName: widget.nameOfScreen);
                } else {
                  productController.searchProducts(query, categoryName: '');
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Text(
                isSearching
                    ? '${productController.searchedProList.value.length.toString()} result found'
                    : '${productController.products.value.length.toString()} result found',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: isSearching == false
                        ? productController.products.length
                        : productController.searchedProList.value.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: isSearching == false
                            ? productController.products.value[index]
                            : productController.searchedProList.value[index],
                        onTapCallBack: () {
                          Get.to(ProductDetails(
                              product: isSearching == false
                                  ? productController.products.value[index]
                                  : productController
                                      .searchedProList.value[index]));
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
