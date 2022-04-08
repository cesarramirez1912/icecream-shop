import '../value_objects/price.dart';

class IceCreamEntity {
  final String id;
  final String descripcion;
  final List<Price> precios;

  IceCreamEntity(
      {required this.id, required this.descripcion, required this.precios});
}
