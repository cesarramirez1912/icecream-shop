import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/features/domain/repositories/insert_sale_repository.dart';
import 'package:icecream_shop/src/features/domain/usecases/delete_sale.dart';
import 'package:icecream_shop/src/features/domain/usecases/get_all_ice_creams.dart';
import 'package:icecream_shop/src/features/domain/usecases/get_all_sales.dart';
import 'package:icecream_shop/src/features/domain/usecases/insert_sale.dart';
import 'package:icecream_shop/src/features/external/ice_cream_firestore_datasource.dart';
import 'package:icecream_shop/src/features/external/sale_firestore_datasource.dart';
import 'package:icecream_shop/src/features/infra/repositories/delete_sale_repository.dart';
import 'package:icecream_shop/src/features/infra/repositories/ice_cream_repository.dart';
import 'package:icecream_shop/src/features/infra/repositories/insert_sale_repository.dart';
import 'package:icecream_shop/src/features/infra/repositories/sale_repository.dart';
import 'package:icecream_shop/src/features/presenter/controllers/ice_creams_controller.dart';
import 'package:icecream_shop/src/features/presenter/controllers/sales_controller.dart';
import '../../../firebase_options.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final firebaseFirestore = FirebaseFirestore.instance;
    Get.put(
      IceCreamsController(
        GetAllIceCreams(
          IceCreamRepository(
            IceCreamFirestoreDataSource(firebaseFirestore),
          ),
        ),
        InsertSale(
          InsertSaleRepository(
            IceCreamFirestoreDataSource(firebaseFirestore),
          ),
        ),
      ),
    );
    Get.put(
      SalesController(
        GetAllSales(
          SalesRepository(
            SaleFirestoreDataSource(firebaseFirestore),
          ),
        ),
        DeleteSale(
          DeleteSaleRepository(
            SaleFirestoreDataSource(firebaseFirestore),
          ),
        ),
      ),
    );
  }
}
