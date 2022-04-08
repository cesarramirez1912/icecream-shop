import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/infra/adapters/json_to_precios.dart';

class JsonToIceCream {
  static IceCreamEntity fromMap(Map json) {
    return IceCreamEntity(
      id: json['id'],
      descripcion: json['descripcion'],
      precios: json.containsKey('precios')
          ? [...(json['precios'] as List).map(JsonToPrecios.fromMap)]
          : [],
    );
  }
}
