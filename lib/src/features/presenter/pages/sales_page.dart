import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/core/utils/date_format.dart';
import 'package:icecream_shop/src/core/utils/money_format.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/value_objects/ice_cream_sale.dart';
import 'package:icecream_shop/src/features/presenter/controllers/sales_controller.dart';
import 'package:icecream_shop/src/features/presenter/widgets/dialog.dart';
import '../../../core/utils/palette.dart';
import '../widgets/title_product.dart';
import 'package:intl/intl.dart';

class SalePage extends StatelessWidget {
  final SalesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ventas',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Palette.SECUNDARY,
        ),
        backgroundColor: Palette.PRIMARY,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetch(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Obx(
            () => ListView.builder(
              itemCount: controller.listOfSales.length,
              itemBuilder: (BuildContext context, int index) {
                SaleEntity _sale = controller.listOfSales[index];
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          title(
                              'Fecha: ' +
                                  DateFormatBr.formatBrFromDateTime(
                                      _sale.fecha),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          IconButton(
                            onPressed: () async {
                              var responseDialog = await dialog(
                                context,
                                'Venta de la fecha: ' +
                                    DateFormatBr.formatBrFromDateTime(
                                        _sale.fecha),
                              );
                              if (responseDialog != null) {
                                if (responseDialog) {
                                  await controller.deleteSaleFromId(index,_sale.id!);
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Palette.RED,
                            ),
                          )
                        ],
                      ),
                      title(totalSection(_sale.productos),
                          fontSize: 16, fontWeight: FontWeight.w500),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      table(_sale.productos)
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String totalSection(List<IceCreamSale> _list) {
    double _total = _list.fold(0, (sum, item) => sum + item.total);
    return 'G\$ ${MoneyFormat.Gs(_total)}';
  }

  Widget table(List<IceCreamSale> _list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DataTable(
          columnSpacing: 0,
          dataRowHeight: 25,
          showCheckboxColumn: false,
          rows: List.generate(
            _list.length,
            (i) => DataRow(cells: [
              DataCell(
                Text(_list[i].descripcion),
              ),
              DataCell(
                Text(
                  MoneyFormat.Gs(_list[i].precio),
                ),
              ),
              DataCell(
                Text(_list[i].cantidad.toString()),
              ),
              DataCell(
                Text(MoneyFormat.Gs(_list[i].total)),
              ),
            ]),
          ),
          columns: dataColumn(),
        ),
      ],
    );
  }

  List<DataColumn> dataColumn() {
    return const <DataColumn>[
      DataColumn(
        label: Text(
          'Producto',
        ),
      ),
      DataColumn(
        label: Text('Precio'),
      ),
      DataColumn(
        label: Text('Cantidad'),
      ),
      DataColumn(
        label: Text('Sub. Total'),
      ),
    ];
  }
// List<Widget> pricesSection(List<Price> precios, int index) {
//   List<Widget> _list = [];
//   for (var i = 0; i < precios.length; i++) {
//     Price _price = precios[i];
//     _list.add(
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             textPrice(_price.precio.toString()),
//             buttonSection(
//               iIceCream: index,
//               iPrice: i,
//               quantity: _price.cantidad,
//               changeQuantity: controller.changeQuantity,
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   return _list;
// }
}
