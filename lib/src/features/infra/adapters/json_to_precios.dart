import 'package:icecream_shop/src/features/domain/value_objects/price.dart';

class JsonToPrecios {
  static Price fromMap(dynamic json) {
    return Price(
      cantidad: 0,
      precio: json,
    );
  }
}
