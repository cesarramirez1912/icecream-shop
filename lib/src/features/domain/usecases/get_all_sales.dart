import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import '../repositories/sales_repository.dart';

abstract class IGetAllSales{
  Stream<List<SaleEntity>> call();
}

class GetAllSales implements IGetAllSales{
  final ISalesRepository salesRepository;

  GetAllSales(this.salesRepository);

  @override
  Stream<List<SaleEntity>> call() {
    return salesRepository.getAllSales();
  }

}