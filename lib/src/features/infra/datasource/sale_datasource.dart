abstract class ISaleDataSource {
  Stream<List<Map>> getAllSales();
  Future<dynamic> deleteSale(String id);
}
