import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icecream_shop/src/features/external/ice_cream_firestore_datasource.dart';

void main() {
  test('testing firestore datasource', () async {
    final firestore = FakeFirebaseFirestore();
    await firestore.collection('productos').add({
      'producto': 'teste',
      'precios': [2000, 3000]
    });
    final dataSource = IceCreamFirestoreDataSource(firestore);
    final result = dataSource.getAllIceCreams();
    expect(result, emits(isA<List<Map>>()));
  });
}
