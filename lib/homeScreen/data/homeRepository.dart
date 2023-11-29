import 'package:fikir_milk/homeScreen/data/homeDataSource.dart';
import 'package:fikir_milk/homeScreen/data/models/supplierModel.dart';

class HomeRepository {
  HomeDataSource homeDataSource;
  HomeRepository(this.homeDataSource);

  Future<Suppliers> getSuppliers() async {
    try {
      final suppliersList = await homeDataSource.getSupplierList();
      print(" Yoooooooooooooooooooooooooooo");
      return suppliersList;
    } catch (e) {
      throw e;
    } //eyobedkebede089@gmail.com
  }
}
