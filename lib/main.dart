import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'core/services/service_locator.dart';
import 'features/purchase/presentation/views/category_screen.dart';
import 'features/purchase/presentation/views/favourite_screen.dart';
import 'features/purchase/presentation/views/product_screen.dart';
import 'features/purchase/presentation/views/user_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  void changeIndex(int ind) {
    setState(() {
      index = ind;
    });
  }

  final List<Widget> _screens = [
    ProductScreen(
      nameOfScreen: 'Products',
    ),
    const CategoryScreen(),
    FavouriteScreen(),
    const UserProfileScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: SizedBox(
          height: 80,
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.black),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.white,
              showUnselectedLabels: true,
              iconSize: 25,
              selectedFontSize: 15,
              unselectedFontSize: 15,
              currentIndex: index,
              onTap: (onTap) {
                changeIndex(onTap);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket_outlined),
                    label: "Products"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: "Categories"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border), label: "Favourites"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "User"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
