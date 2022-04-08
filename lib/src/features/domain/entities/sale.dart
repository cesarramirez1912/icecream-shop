import 'package:icecream_shop/src/features/domain/value_objects/ice_cream_sale.dart';

class SaleEntity {
  String? id;
  final DateTime fecha;
  final List<IceCreamSale> productos;

  SaleEntity({this.id, required this.fecha, required this.productos});
}
