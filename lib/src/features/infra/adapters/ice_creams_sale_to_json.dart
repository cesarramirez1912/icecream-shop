import 'package:icecream_shop/src/features/domain/value_objects/ice_cream_sale.dart';

class IceCreamSaleToJson {
  static Map<String, dynamic> toJson(IceCreamSale iceCreamSale) {
    return {
      'id': iceCreamSale.id,
      'descripcion': iceCreamSale.descripcion,
      'precio': iceCreamSale.precio,
      'total': iceCreamSale.total,
      'cantidad': iceCreamSale.cantidad,
    };
  }
}
