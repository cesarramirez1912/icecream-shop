import 'package:cloud_firestore/cloud_firestore.dart';
import '../infra/datasource/sale_datasource.dart';

class SaleFirestoreDataSource implements ISaleDataSource {
  final FirebaseFirestore firestore;

  SaleFirestoreDataSource(this.firestore);

  @override
  Stream<List<Map>> getAllSales() {
    final ref = firestore.collection('ventas').orderBy("fecha", descending: true);
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
  Future deleteSale(String id) async {
    CollectionReference ventas = firestore.collection('ventas');
    return await ventas.doc(id).delete();
  }
}
