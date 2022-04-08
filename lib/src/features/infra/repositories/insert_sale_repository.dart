import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/repositories/ice_cream_repository.dart';
import 'package:icecream_shop/src/features/domain/repositories/insert_sale_repository.dart';
import 'package:icecream_shop/src/features/infra/adapters/json_to_ice_creams.dart';
import 'package:icecream_shop/src/features/infra/datasource/ice_cream_datasource.dart';

class InsertSaleRepository implements IInsertSaleRepository {
  final IIceCreamDataSource iceCreamDataSource;

  InsertSaleRepository(this.iceCreamDataSource);

  @override
  Future insertNewSale(saleEntity) async => await iceCreamDataSource.insertSale(saleEntity);
}
