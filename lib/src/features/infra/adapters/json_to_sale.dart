import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/infra/adapters/json_to_ice_creams_sale.dart';

class JsonToSale {
  static SaleEntity fromMap(Map json) {
    return SaleEntity(
      id: json['id'],
      fecha: (json['fecha'] as Timestamp).toDate(),
      productos: json.containsKey('productos')
          ? [...(json['productos'] as List).map(JsonToIceCreamSale.fromMap)]
          : [],
    );
  }
}
