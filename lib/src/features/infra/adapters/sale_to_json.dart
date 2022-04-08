import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/infra/adapters/ice_creams_sale_to_json.dart';

class SaleToJson {
  static Map<String, dynamic> toJson(SaleEntity sale) {
    return {
      'id': sale.id,
      'fecha': Timestamp.fromDate(sale.fecha),
      'productos': [...sale.productos.map(IceCreamSaleToJson.toJson)],
    };
  }
}
