import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/repositories/ice_cream_repository.dart';
import 'package:icecream_shop/src/features/infra/adapters/json_to_sale.dart';

class IceCreamRepositoryMock extends Mock implements IIceCreamRepository {}

class IceCreamEntityMock extends Mock implements IceCreamEntity {}

void main() {
  test('converter um json para um SaleEntity', () {
    final iceCream = JsonToSale.fromMap({
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
    });
    expect(iceCream, isA<SaleEntity>());
  });
}
