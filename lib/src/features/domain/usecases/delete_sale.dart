import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/repositories/delete_sale_repository.dart';

import '../repositories/insert_sale_repository.dart';

abstract class IDeleteSale {
  Future<void> call(String id);
}

class DeleteSale implements IDeleteSale {
  final IDeleteSaleRepository iDeleteSaleRepository;

  DeleteSale(this.iDeleteSaleRepository);

  @override
  Future<dynamic> call(String id) async {
    return await iDeleteSaleRepository.deleteSale(id);
  }
}
