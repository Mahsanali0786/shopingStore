import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestore/features/purchase/data/datasources/prod_remote_datasrc.dart';
import 'package:mobilestore/features/purchase/presentation/controller/product_controller.dart';
import 'package:mobilestore/features/purchase/presentation/views/product_details.dart';
import 'package:mobilestore/features/purchase/presentation/widgets/product_card.dart';

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
    ProudctController proudctController = Get.find<ProudctController>();
    if (widget.isCategory == true && widget.nameOfScreen != '') {
      proudctController.getSearchedProducts(widget.nameOfScreen.toString());
    } else {
      proudctController.getProducts();
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
            SearchBar(
              controller: searchController,
              hintText: 'search',
              leading: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onSubmitted: (value) async {
                proudctController.getSearchedProducts(value);
              },
              shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              constraints: const BoxConstraints(minHeight: 45, maxHeight: 45),
              side: MaterialStateProperty.all(
                  const BorderSide(width: 1, color: Colors.black)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
              elevation: MaterialStateProperty.all(0),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Text(
                '${proudctController.totalProducts} results found',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: proudctController.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: proudctController.products.value[index],
                        onTapCallBack: () {
                          Get.to(ProductDetails(
                              product:
                                  proudctController.products.value[index]));
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
