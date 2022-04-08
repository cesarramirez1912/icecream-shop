
import '../entities/ice_cream_entity.dart';
import '../repositories/ice_cream_repository.dart';

abstract class IGetAllIceCreams{
  Stream<List<IceCreamEntity>> call();
}

class GetAllIceCreams implements IGetAllIceCreams{
  final IIceCreamRepository iceCreamRepository;

  GetAllIceCreams(this.iceCreamRepository);

  @override
  Stream<List<IceCreamEntity>> call() {
    return iceCreamRepository.getAllIceCreams();
  }

}