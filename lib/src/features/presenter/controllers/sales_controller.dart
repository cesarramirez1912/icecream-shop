import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/usecases/get_all_sales.dart';
import 'package:icecream_shop/src/features/domain/value_objects/ice_cream_sale.dart';
import 'package:icecream_shop/src/features/presenter/widgets/dialog_fetch.dart';
import 'package:icecream_shop/src/features/presenter/widgets/stackbar.dart';

import '../../domain/usecases/delete_sale.dart';
import '../../domain/usecases/get_all_ice_creams.dart';

class SalesController extends GetxController {
  GetAllSales useCase;
  DeleteSale deleteSale;

  SalesController(this.useCase, this.deleteSale);

  RxList<SaleEntity> listOfSales = <SaleEntity>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    List<SaleEntity> res = await useCase.call().first;
    listOfSales.clear();
    listOfSales.addAll(res);
  }

  Future<void> deleteSaleFromId(int index, String id) async {
    await dialogFecth(() async {
      await deleteSale.call(id);
      listOfSales.removeAt(index);
    }).then((value) => CustomSnack.success('Venta eliminada con exito!'));
  }

  void addSaleInIndexList(int index, SaleEntity _sale, bool isUpdate) {
    List<SaleEntity> _listAux = List.of(listOfSales);
    if (!isUpdate) {
      _listAux.insert(0, _sale);
    } else {
      _listAux[index] = _sale;
    }
    listOfSales.clear();
    listOfSales.addAll(_listAux);
  }

  List<IceCreamSale> groupProducts(SaleEntity _sale) {
    List<IceCreamSale> _newList = [];
    for (var i = 0; i < _sale.productos.length; i++) {
      IceCreamSale _iceCream = _sale.productos[i];
      var index = _newList.indexWhere((element) => element.id == _iceCream.id);
      if (index != -1) {
        IceCreamSale newProducto = IceCreamSale(
            id: _iceCream.id,
            descripcion: _iceCream.descripcion,
            precio: _iceCream.precio,
            cantidad: _newList[index].cantidad + _iceCream.cantidad,
            total: _newList[index].total + _iceCream.total);
        _newList[index] = newProducto;
      } else {
        _newList.add(_iceCream);
      }
    }
    return _newList;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    useCase.call().listen((event) {}).cancel();
    super.dispose();
  }
}
