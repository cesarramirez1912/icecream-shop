import 'package:icecream_shop/src/features/domain/entities/sale.dart';

abstract class IIceCreamDataSource {
  Stream<List<Map>> getAllIceCreams();
  Future<dynamic> insertSale(SaleEntity saleEntity);
}
