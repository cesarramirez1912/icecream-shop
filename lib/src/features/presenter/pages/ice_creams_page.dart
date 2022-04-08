import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/domain/value_objects/price.dart';
import 'package:icecream_shop/src/features/presenter/controllers/ice_creams_controller.dart';
import 'package:icecream_shop/src/features/presenter/controllers/sales_controller.dart';
import 'package:icecream_shop/src/features/presenter/widgets/button_section.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/palette.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/price_product.dart';
import '../widgets/title_product.dart';

class IceCreamsPage extends StatelessWidget {
  final IceCreamsController controller = Get.find();
  final SalesController salesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                DateFormatBr.formatBrFromDateTime(controller.date.value),
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            IconButton(
              onPressed: () => controller.changeDate(context),
              icon: const Icon(
                Icons.date_range,
                color: Colors.black,
              ),
            )
          ],
        ),
        iconTheme: const IconThemeData(
          color: Palette.SECUNDARY,
        ),
        backgroundColor: Palette.PRIMARY,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.listOfIceCreams.length,
            itemBuilder: (BuildContext context, int index) {
              IceCreamEntity _iceCream = controller.listOfIceCreams[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(_iceCream.descripcion,fontSize: 22),
                    ...pricesSection(_iceCream.precios, index),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Palette.GREEN, alignment: Alignment.center),
            onPressed: () =>
                controller.isLoading.value ? null : controller.saveSales(context),
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.8,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'FINALIZAR VENTA',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ),
      drawer: drawerMenu(),
    );
  }

  List<Widget> pricesSection(List<Price> precios, int index) {
    List<Widget> _list = [];
    for (var i = 0; i < precios.length; i++) {
      Price _price = precios[i];
      _list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textPrice(_price.precio.toString()),
              buttonSection(
                iIceCream: index,
                iPrice: i,
                quantity: _price.cantidad,
                changeQuantity: controller.changeQuantity,
              )
            ],
          ),
        ),
      );
    }
    return _list;
  }
}
