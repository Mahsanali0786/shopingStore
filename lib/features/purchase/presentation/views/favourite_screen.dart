import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestore/features/purchase/presentation/controller/product_controller.dart';
import 'package:mobilestore/features/purchase/presentation/widgets/fav_card.dart';
import 'package:mobilestore/features/purchase/presentation/widgets/search_bar.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({super.key, this.isLeading = false});
  bool isLeading;

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late TextEditingController favController;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    favController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    favController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProudctController proudctController = Get.find<ProudctController>();
    proudctController.getProducts();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Favourite',
          style: TextStyle(
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
                searchFieldController: favController,
                onChangeCallBack: (String query) {
                  setState(() {
                    isSearching = true;
                  });
                  proudctController.searchFavouriteProduct(query);
                }),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Text(
                isSearching
                    ? '${proudctController.searchedFavProList.length} results found'
                    : '${proudctController.favouritesIdList.length} results found',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: Obx(
              () => ListView.builder(
                  itemCount: isSearching
                      ? proudctController.searchedFavProList.value.length
                      : proudctController.favouritesProductList.value.length,
                  itemBuilder: (context, index) {
                    final product = isSearching
                        ? proudctController.searchedFavProList.value[index]
                        : proudctController.favouritesProductList.value[index];
                    return FavCard(
                      product: product,
                      onPressedCallBack: () {
                        proudctController.addRemoveFromFavList(product);
                      },
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
