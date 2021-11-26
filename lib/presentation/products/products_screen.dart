import 'package:cleanarchitechgetx/domain/models/product.dart';
import 'package:cleanarchitechgetx/presentation/favorit/favorit_controller.dart';
import 'package:cleanarchitechgetx/presentation/products/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final controller = Get.put<ProductController>(
      ProductController(apiRepositoryInterface: Get.find()));

  final FavoritController favoritController = Get.find<FavoritController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("List Product"),
      ),
      body: Container(
        color: Colors.red,
        child: Obx(() {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: controller.productList.length,
              itemBuilder: (BuildContext ctx, index) {
                final item = controller.productList[index];

                if (item is Product) {
                  return ProductItem(
                    item: item,
                    onPress: () {
                      favoritController.add(item);
                    },
                  );
                }

                return const SizedBox.shrink();
              });
        }),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.item,
    required this.onPress,
  }) : super(key: key);

  final Product item;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[100],
      child: Column(
        children: [
          Image.network(item.image),
          Text(item.name),
          Text("\$${item.pirce}"),
          TextButton(onPressed: onPress, child: const Text('Add'))
        ],
      ),
    );
  }
}
