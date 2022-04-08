import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/infra/adapters/json_to_sale.dart';
import 'package:icecream_shop/src/features/infra/datasource/sale_datasource.dart';

import '../../domain/repositories/sales_repository.dart';

class SalesRepository implements ISalesRepository {
  final ISaleDataSource saleDataSource;

  SalesRepository(this.saleDataSource);

  @override
  Stream<List<SaleEntity>> getAllSales() {
    final streams = saleDataSource.getAllSales();
    return streams.map(_convert);
  }

  List<SaleEntity> _convert(List<Map> list) {
    return list.map(JsonToSale.fromMap).toList();
  }
}
