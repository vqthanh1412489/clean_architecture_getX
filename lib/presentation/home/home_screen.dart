import 'package:cleanarchitechgetx/presentation/favorit/favorit_controller.dart';
import 'package:cleanarchitechgetx/presentation/favorit/favorit_screen.dart';
import 'package:cleanarchitechgetx/presentation/home/home_controller.dart';
import 'package:cleanarchitechgetx/presentation/products/products_screen.dart';
import 'package:cleanarchitechgetx/presentation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  final FavoritController favoritController = Get.find<FavoritController>();

  final List<Widget> _views = [
    ProductScreen(),
    // const ChatView(),
    FavoriteVIew(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            Container(
              height: 100,
              color: Colors.green[100],
              width: double.infinity,
              child:
                  Center(child: Text(favoritController.totalItems.toString())),
            ),
            Expanded(
              child: IndexedStack(
                children: _views,
                index: controller.currentIndex.value,
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        currentIndex: controller.currentIndex.value,
        onTap: (index) {
          controller.onIndexSelected(index);
        },
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(UniconsSolid.history), label: ""),
          // BottomNavigationBarItem(
          //     icon: Icon(UniconsSolid.comment_dots), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(UniconsLine.heart), label: ""),
          BottomNavigationBarItem(icon: Icon(UniconsLine.user), label: ""),
        ],
      ),
    );
  }
}
