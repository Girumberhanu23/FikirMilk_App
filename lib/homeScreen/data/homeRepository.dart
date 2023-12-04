import 'package:fikir_milk/homeScreen/data/homeDataSource.dart';
import 'package:fikir_milk/homeScreen/data/models/createSupplier.dart';
import 'package:fikir_milk/homeScreen/data/models/supplierModel.dart';
import 'package:fikir_milk/homeScreen/data/models/updateSupplier.dart';

class HomeRepository {
  HomeDataSource homeDataSource;
  HomeRepository(this.homeDataSource);

  Future<List<Suppliers>> getSuppliers() async {
    try {
      final suppliersList = await homeDataSource.getSupplierList();
      return suppliersList;
    } catch (e) {
      throw e;
    } //eyobedkebede089@gmail.com
  }

  Future createSupplier(CreateSupplier addSupplierToList) async {
    try {
      await homeDataSource.createSupplier(addSupplierToList);
      print('check Repoooooooooooo Afterrrrrr');
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateSupplier(UpdateSupplier updateSupplier) async {
    try {
      await homeDataSource.updateSupplier(updateSupplier);
    } catch (e) {
      print('Error updating supplier in repository: $e');
      throw e;
    }
  }

  Future deleteSupplier(String? deleteId) async {
    try {
      await homeDataSource.deleteSupplier(deleteId);
    } catch (e) {
      throw e;
    }
  }
}
