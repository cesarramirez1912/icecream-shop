
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/repositories/sales_repository.dart';
import 'package:icecream_shop/src/features/domain/usecases/get_all_sales.dart';

class SalesRepositoryMock extends Mock implements ISalesRepository{}
class SaleEntityMock extends Mock implements SaleEntity{}

void main() {

  test('deve retornar uma lista de vendas',(){
    final salesRepository = SalesRepositoryMock();
    final saleEntity = SaleEntityMock();
    when(()=>salesRepository.getAllSales()).
    thenAnswer((invocation)  => Stream.value([saleEntity]) );
    final useCase = GetAllSales(salesRepository);
    final result = useCase.call();
    expect(result, emits(isA<List<SaleEntity>>()));
  });
}
