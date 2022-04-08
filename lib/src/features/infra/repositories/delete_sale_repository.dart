import 'package:icecream_shop/src/features/infra/datasource/sale_datasource.dart';

import '../../domain/repositories/delete_sale_repository.dart';

class DeleteSaleRepository implements IDeleteSaleRepository {
  final ISaleDataSource iceCreamDataSource;

  DeleteSaleRepository(this.iceCreamDataSource);

  @override
  Future deleteSale(id) async => await iceCreamDataSource.deleteSale(id);
}
