import 'package:icecream_shop/src/features/domain/value_objects/ice_cream_sale.dart';

class JsonToIceCreamSale {
  static IceCreamSale fromMap(dynamic json) {
    return IceCreamSale(
      id: json['id'],
      descripcion: json['descripcion'],
      precio: json['precio'],
      total: json['total'],
      cantidad: json['cantidad'],
    );
  }
}
