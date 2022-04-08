import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/domain/repositories/ice_cream_repository.dart';
import 'package:icecream_shop/src/features/infra/adapters/json_to_ice_creams.dart';

class IceCreamRepositoryMock extends Mock implements IIceCreamRepository {}

class IceCreamEntityMock extends Mock implements IceCreamEntity {}

void main() {
  test('converter um json para um IceCreamEntity', () {
    final iceCream = JsonToIceCream.fromMap({
      'id':'zJkzXml',
      'descripcion': 'helado',
      'precios': [2000, 3000]
    });
    expect(iceCream, isA<IceCreamEntity>());
  });
}
