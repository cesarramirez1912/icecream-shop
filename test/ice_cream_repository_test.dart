
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/domain/repositories/ice_cream_repository.dart';
import 'package:icecream_shop/src/features/domain/usecases/get_all_ice_creams.dart';
import 'package:icecream_shop/src/features/infra/datasource/ice_cream_datasource.dart';
import 'package:icecream_shop/src/features/infra/repositories/ice_cream_repository.dart';

class IceCreamRepositoryMock extends Mock implements IIceCreamRepository{}
class IceCreamEntityMock extends Mock implements IceCreamEntity{}
class IceCreamDataSourceMock extends Mock implements IIceCreamDataSource{}

void main() {
  test('ice cream repository testing',(){
   final dataSource = IceCreamDataSourceMock();
   final repositoryIceCream = IceCreamRepository(dataSource);
   when(()=>dataSource.getAllIceCreams()).thenAnswer((invocation) => Stream.value([
     {
       'descripcion':'helado',
       'precios':[
         2000,
         3000
       ]
     }
   ]));
   final response = repositoryIceCream.getAllIceCreams();
   expect(response,emits(
     isA<List<IceCreamEntity>>()
   ));
  });
}
