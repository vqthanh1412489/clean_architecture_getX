import 'package:cleanarchitechgetx/domain/models/product_card.dart';
import 'package:cleanarchitechgetx/presentation/favorit/favorit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class FavoriteVIew extends StatelessWidget {
  final controller = Get.put<FavoritController>(
      FavoritController(apiRepositoryInterface: Get.find()));

  FavoriteVIew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Card"),
      ),
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              _buildList(),
              _buildBill(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildBill() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 100,
          ),
          Text('Number of items: ${controller.totalItems}'),
          Text('Totol cost: \$${controller.totalCost}'),
        ],
      ),
    );
  }

  Container _buildList() {
    return Container(
      height: 200.0,
      color: Colors.white,
      child: ListView.builder(
          itemCount: controller.cardList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            var item = controller.cardList[index];

            if (item is ProductCard) {
              return ProductCardItem(
                item: item,
                decrease: () {
                  controller.decrement(item);
                },
                increase: () {
                  controller.increment(item);
                },
                delete: () {
                  controller.delete(item);
                },
              );
            }

            return const SizedBox.shrink();
          }),
    );
  }
}

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    Key? key,
    required this.item,
    required this.increase,
    required this.decrease,
    required this.delete,
  }) : super(key: key);

  final ProductCard item;
  final VoidCallback increase;
  final VoidCallback decrease;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 30,
                height: 30,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: delete,
                )),
            SizedBox(
              width: 50,
              height: 50,
              child: item.product.image != ''
                  ? Image.network(item.product.image)
                  : Container(
                      color: Colors.black,
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(item.product.name),
            const SizedBox(
              width: 4,
            ),
            Text(item.product.pirce.toString()),
            const SizedBox(
              width: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    // width: 20.0,
                    // height: 20.0,
                    child: IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: decrease)),
                const SizedBox(
                  width: 4,
                ),
                Text(item.quantity.toString()),
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                    // width: 20.0,
                    // height: 20.0,
                    child: IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: increase)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
