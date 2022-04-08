
import 'package:flutter_test/flutter_test.dart';
import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:icecream_shop/src/features/domain/repositories/ice_cream_repository.dart';
import 'package:icecream_shop/src/features/domain/usecases/get_all_ice_creams.dart';

class IceCreamRepositoryMock extends Mock implements IIceCreamRepository{}
class IceCreamEntityMock extends Mock implements IceCreamEntity{}

void main() {

  test('deve retornar uma lista de sorvetes',(){
    final iceCreamRepository = IceCreamRepositoryMock();
    final iceCreamEntity = IceCreamEntityMock();
    when(()=>iceCreamRepository.getAllIceCreams()).
    thenAnswer((invocation)  => Stream.value([iceCreamEntity]) );
    final useCase = GetAllIceCreams(iceCreamRepository);
    final result = useCase.call();
    expect(result, emits(isA<List<IceCreamEntity>>()));
  });
}
