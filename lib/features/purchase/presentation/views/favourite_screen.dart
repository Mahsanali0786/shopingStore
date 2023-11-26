import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestore/features/purchase/presentation/controller/product_controller.dart';
import 'package:mobilestore/features/purchase/presentation/widgets/fav_card.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({super.key, this.isLeading = false});
  bool isLeading;

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late TextEditingController favController;

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
            SearchBar(
              controller: favController,
              hintText: 'search',
              leading: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onChanged: (value) async {},
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
                '${proudctController.favouritesIdList.length} results found',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(()=>ListView.builder(

                      itemCount:
                      proudctController.favouritesProductList.value.length,
                      itemBuilder: (context, index) {
                      final product = proudctController.favouritesProductList.value[index];
                        return FavCard(
                          product: product,
                          onPressedCallBack: () {
                            proudctController.addRemoveFromFavList(product);
                          },
                        );
                      }),
              )

            ),
          ],
        ),
      ),
    );
  }
}


