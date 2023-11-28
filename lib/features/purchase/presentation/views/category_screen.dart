import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestore/features/purchase/presentation/controller/product_controller.dart';
import 'package:mobilestore/features/purchase/presentation/views/product_screen.dart';
import 'package:mobilestore/features/purchase/presentation/widgets/search_bar.dart';

import '../../../../core/utils/constants.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final TextEditingController categoryController;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProudctController proudctController = Get.find<ProudctController>();
    proudctController.getCategories();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Categories',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'playfair',
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomSearchBar(
              searchFieldController: categoryController,
              onChangeCallBack: (String query) {
                setState(() {
                  isSearching = true;
                });
                proudctController.searchCategories(query);
              }),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(
              () => GridView.builder(
                itemCount: isSearching
                    ? proudctController.searchedCategories.value.length
                    : proudctController.listCategories.value.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    String categoryName = isSearching
                        ? proudctController.searchedCategories.value[index]
                            .toString()
                        : proudctController.listCategories.value[index]
                            .toString();
                    Get.to(ProductScreen(
                      nameOfScreen: categoryName,
                      isCategory: true,
                      isLeading: true,
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 20, left: 10),
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: const ColorFilter.mode(
                              Colors.black26, BlendMode.darken),
                          fit: BoxFit.cover,
                          image: NetworkImage(catImagesUrl[index].toString()),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      isSearching
                          ? proudctController.searchedCategories.value[index]
                              .toString()
                          : proudctController.listCategories.value[index]
                              .toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
