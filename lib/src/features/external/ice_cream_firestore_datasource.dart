import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icecream_shop/src/features/domain/entities/sale.dart';
import 'package:icecream_shop/src/features/infra/adapters/sale_to_json.dart';
import 'package:icecream_shop/src/features/infra/datasource/ice_cream_datasource.dart';

class IceCreamFirestoreDataSource implements IIceCreamDataSource {
  final FirebaseFirestore firestore;

  IceCreamFirestoreDataSource(this.firestore);

  @override
  Stream<List<Map>> getAllIceCreams() {
    final ref = firestore.collection('productos');
    final snapshot = ref.snapshots();
    return snapshot.map((event) => event.docs).map(_convert);
  }

  List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs
        .map(
          (e) => {'id': e.id, ...e.data()},
        )
        .toList();
  }

  @override
  Future<dynamic> insertSale(SaleEntity saleEntity) async {
    CollectionReference ventas = firestore.collection('ventas');
    Map<String, dynamic> _body = SaleToJson.toJson(saleEntity);
    if (_body['id'] == null) {
      _body.remove('id');
      return await ventas.add(_body);
    } else {
      return await ventas.doc(_body['id']).update({
        'productos': _body['productos'],
      });
    }
  }
}
