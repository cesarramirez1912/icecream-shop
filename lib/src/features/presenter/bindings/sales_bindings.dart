import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/features/domain/usecases/delete_sale.dart';
import 'package:icecream_shop/src/features/domain/usecases/get_all_ice_creams.dart';
import 'package:icecream_shop/src/features/domain/usecases/get_all_sales.dart';
import 'package:icecream_shop/src/features/external/sale_firestore_datasource.dart';
import 'package:icecream_shop/src/features/infra/repositories/delete_sale_repository.dart';
import 'package:icecream_shop/src/features/infra/repositories/ice_cream_repository.dart';
import 'package:icecream_shop/src/features/infra/repositories/sale_repository.dart';
import 'package:icecream_shop/src/features/presenter/controllers/ice_creams_controller.dart';
import 'package:icecream_shop/src/features/presenter/controllers/sales_controller.dart';

import '../../external/ice_cream_firestore_datasource.dart';

class SalesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesController>(
      () => SalesController(
        GetAllSales(
          SalesRepository(
            SaleFirestoreDataSource(FirebaseFirestore.instance),
          ),
        ),
        DeleteSale(
          DeleteSaleRepository(
            SaleFirestoreDataSource(FirebaseFirestore.instance),
          ),
        ),
      ),
    );
  }
}
