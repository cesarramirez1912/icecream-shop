import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/core/utils/date_format.dart';
import 'package:icecream_shop/src/features/domain/entities/ice_cream_entity.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/domain/usecases/delete_sale.dart';
import 'package:icecream_shop/src/features/domain/usecases/insert_sale.dart';
import 'package:icecream_shop/src/features/domain/value_objects/ice_cream_sale.dart';
import 'package:icecream_shop/src/features/presenter/controllers/sales_controller.dart';
import 'package:icecream_shop/src/features/presenter/widgets/stackbar.dart';

import '../../domain/usecases/get_all_ice_creams.dart';
import '../widgets/dialog_fetch.dart';

class IceCreamsController extends GetxController {
  GetAllIceCreams useCase;
  InsertSale insertUseCase;

  IceCreamsController(this.useCase, this.insertUseCase);

  RxList<IceCreamEntity> listOfIceCreams = <IceCreamEntity>[].obs;
  Rx<DateTime> date = DateTime
      .utc(
      DateTime
          .now()
          .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day, 4)
      .obs;

  RxBool isLoading = false.obs;

  @override
  Future<void> onReady() async {
    await dialogFecth(() async {
      await fetch();
    });
    super.onReady();
  }

  Future<void> fetch() async {
    try {
      List<IceCreamEntity> res = await useCase
          .call()
          .first;
      listOfIceCreams.addAll(res);
    } catch (e) {
      CustomSnack.error(e.toString());
    }
  }

  void changeQuantity(
      {required int iIceCream, required int iPrice, required String operator}) {
    List<IceCreamEntity> listAux = [...listOfIceCreams];
    if (operator == '+') {
      listAux[iIceCream].precios[iPrice].cantidad =
          listAux[iIceCream].precios[iPrice].cantidad + 1;
    } else {
      if (listAux[iIceCream].precios[iPrice].cantidad > 0) {
        listAux[iIceCream].precios[iPrice].cantidad =
            listAux[iIceCream].precios[iPrice].cantidad - 1;
      }
    }
    listOfIceCreams.clear();
    listOfIceCreams.addAll(listAux);
  }

  Future<void> saveSales(BuildContext context) async {
    await dialogFecth(() async {
      List<IceCreamSale> _list = [];
      for (var i = 0; i < listOfIceCreams.length; i++) {
        for (var j = 0; j < listOfIceCreams[i].precios.length; j++) {
          if (listOfIceCreams[i].precios[j].cantidad > 0) {
            _list.add(
              IceCreamSale(
                id: listOfIceCreams[i].id,
                descripcion: listOfIceCreams[i].descripcion,
                precio: listOfIceCreams[i].precios[j].precio,
                cantidad: listOfIceCreams[i].precios[j].cantidad,
                total: (listOfIceCreams[i].precios[j].precio *
                    listOfIceCreams[i].precios[j].cantidad),
              ),
            );
          }
        }
      }
      if (_list.isNotEmpty) {
        SalesController _saleController = Get.find();
        SaleEntity _newSale =
        SaleEntity(fecha: date.value, productos: List.of(_list));
        List<dynamic> idAndIndex = verifyAndReturnIdAndIndex();
        int _index = 0;
        bool isUpdate = false;
        if (idAndIndex.isNotEmpty) {
          isUpdate = true;
          _index = idAndIndex[0];
          String _id = idAndIndex[1];
          _newSale.id = _id;
          _newSale.productos.clear();
          _newSale.productos.addAll(unionListProducts(_index, List.of(_list)));
          var res = await insertUseCase.call(_newSale);
        } else {
          DocumentReference<Map<String, dynamic>> res =
          await insertUseCase.call(_newSale);
          _newSale.id = res.id;
        }
        _saleController.addSaleInIndexList(_index, _newSale, isUpdate);
        cleanValues();
      } else {
        CustomSnack.error('Ningun producto con cantidad mayor que 0');
      }
    }).then((value) {
      CustomSnack.success('Venta registrada con exito');
    });
  }

  Future<void> changeDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: date.value,
        firstDate: DateTime(2019, 12),
        lastDate: DateTime(2101));
    if (picked != null && picked != date.value) {
      date.value = picked;
    }
  }

  void cleanValues() {
    List<IceCreamEntity> _auxList = [...listOfIceCreams];
    for (var i = 0; i < _auxList.length; i++) {
      for (var j = 0; j < _auxList[i].precios.length; j++) {
        _auxList[i].precios[j].cantidad = 0;
      }
    }
    listOfIceCreams.clear();
    listOfIceCreams.addAll(_auxList);
  }

  List<dynamic> verifyAndReturnIdAndIndex() {
    SalesController _saleController = Get.find();
    int index = _saleController.listOfSales.indexWhere(
          (element) =>
      DateFormatBr.formatBrFromDateTime(element.fecha) ==
          DateFormatBr.formatBrFromDateTime(date.value),
    );
    if (index == -1) {
      return [];
    } else {
      return [index, _saleController.listOfSales[index].id!];
    }
  }

  List<IceCreamSale> unionListProducts(int index,
      List<IceCreamSale> _listProductsSelected) {
    SalesController _saleController = Get.find();
    final List<IceCreamSale> _productsFromSale =
    List.of(_saleController.listOfSales[index].productos);
    final List<IceCreamSale> _productsFromSaleAndNewProducts = [];
    final List<IceCreamSale> _newItems = [];
    _productsFromSaleAndNewProducts.addAll(_productsFromSale);
    _productsFromSaleAndNewProducts.addAll(_listProductsSelected);
    for (var i = 0; i < _productsFromSaleAndNewProducts.length; i++) {
      var _product = _productsFromSaleAndNewProducts[i];
      var index = _newItems.indexWhere((element) =>
      element.id == _product.id && element.precio == _product.precio);
      if (index == -1) {
        _newItems.add(_product);
      } else {
        final IceCreamSale newProducto = IceCreamSale(
            id: _newItems[index].id,
            descripcion: _newItems[index].descripcion,
            precio: _newItems[index].precio,
            cantidad: _newItems[index].cantidad + _product.cantidad,
            total: _newItems[index].total + _product.total);
        _newItems[index] = newProducto;
      }
    }
    return _newItems;
  }
}
