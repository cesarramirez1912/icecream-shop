import 'package:get/get.dart';
import 'package:icecream_shop/src/features/presenter/bindings/ice_creams_bindings.dart';
import 'package:icecream_shop/src/features/presenter/bindings/sales_bindings.dart';
import 'package:icecream_shop/src/features/presenter/pages/sales_page.dart';
import '../../features/presenter/pages/ice_creams_page.dart';

class AppRoutes {
  static const String ICE_CREAMS = '/';
  static const String VENTAS = '/ventas';

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.ICE_CREAMS,
      page: () => IceCreamsPage(),
      binding: IceCreamsBindings(),
    ),
    GetPage(
      name: AppRoutes.VENTAS,
      page: () => SalePage(),
      binding: SalesBindings(),
    ),
  ];
}
