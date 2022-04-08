import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icecream_shop/src/features/external/sale_firestore_datasource.dart';

void main() {
  test('testing firestore datasource from sales', () async {
    final firestore = FakeFirebaseFirestore();
    await firestore.collection('ventas').add({
      'id': 'zJkzXmlk',
      'fecha': '23 de enero 2022',
      'productos': [
        {
          'id': 'zJkzXml',
          'descripcion': 'helado',
          'precios': 2000,
          'cantidad': 2,
          'total': 4000,
        }
      ]
    });
    final dataSource = SaleFirestoreDataSource(firestore);
    final result = dataSource.getAllSales();
    expect(result, emits(isA<List<Map>>()));
  });
}
