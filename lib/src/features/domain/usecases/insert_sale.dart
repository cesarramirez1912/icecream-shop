import 'package:icecream_shop/src/features/domain/entities/sale.dart';

import '../repositories/insert_sale_repository.dart';

abstract class IInsertSale {
  Future<void> call(SaleEntity saleEntity);
}

class InsertSale implements IInsertSale {
  final IInsertSaleRepository iInsertSaleRepository;

  InsertSale(this.iInsertSaleRepository);

  @override
  Future<dynamic> call(SaleEntity saleEntity) async {
    return await iInsertSaleRepository.insertNewSale(saleEntity);
  }
}
