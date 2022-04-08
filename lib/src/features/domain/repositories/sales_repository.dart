import 'package:icecream_shop/src/features/domain/entities/sale.dart';

abstract class ISalesRepository {
  Stream<List<SaleEntity>> getAllSales();
}
