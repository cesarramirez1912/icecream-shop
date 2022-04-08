import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/repositories/ice_cream_repository.dart';
import 'package:icecream_shop/src/features/infra/adapters/json_to_ice_creams.dart';
import 'package:icecream_shop/src/features/infra/datasource/ice_cream_datasource.dart';

class IceCreamRepository implements IIceCreamRepository {
  final IIceCreamDataSource iceCreamDataSource;

  IceCreamRepository(this.iceCreamDataSource);

  @override
  Stream<List<IceCreamEntity>> getAllIceCreams() {
    final streams = iceCreamDataSource.getAllIceCreams();
    return streams.map(_convert);
  }

  List<IceCreamEntity> _convert(List<Map> list) {
    return list.map(JsonToIceCream.fromMap).toList();
  }

}
