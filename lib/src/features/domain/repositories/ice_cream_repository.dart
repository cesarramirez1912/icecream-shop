import '../entities/ice_cream_entity.dart';

abstract class IIceCreamRepository {
  Stream<List<IceCreamEntity>> getAllIceCreams();
}
