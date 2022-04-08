import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/repositories/sales_repository.dart';
import 'package:icecream_shop/src/features/infra/datasource/sale_datasource.dart';
import 'package:icecream_shop/src/features/infra/repositories/sale_repository.dart';

class SalesRepositoryMock extends Mock implements ISalesRepository {}

class SaleEntityMock extends Mock implements SaleEntity {}

class SaleDataSourceMock extends Mock implements ISaleDataSource {}

void main() {
  test('ice cream sale repository testing', () {
    final dataSource = SaleDataSourceMock();
    final repositoryIceCreamSale = SalesRepository(dataSource);
    when(() => dataSource.getAllSales())
        .thenAnswer((invocation) => Stream.value([
              {
                'id': 'zJkzXmlk',
                'fecha': '23 de enero 2022',
                'productos': [
                  {
                    'id': 'zJkzXml',
                    'descripcion': 'helado',
                    'precios': 2000,
                    'cantidad': 2,
                    'total': 4000,
                  }
                ]
              }
            ]));
    final response = repositoryIceCreamSale.getAllSales();
    expect(response, emits(isA<List<SaleEntity>>()));
  });
}
