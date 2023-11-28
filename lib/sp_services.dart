import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future login(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("password", password);
  }

  Future readLogin() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("password");
    return cache;
  }

  Future signout() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("password");
  }

  Future storeToken(String token) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("token", token);
  }

  Future readToken() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("token");
    return cache;
  }

  Future removeToken() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("token");
  }

  Future setUserId(String id) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("UserID", id);
  }

  Future getUserId() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("UserID");
    return cache;
  }

  Future addSupplier(String supplierName) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("supplierName", supplierName);
  }

  Future readAddedESupplier() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("supplierName");
    return cache;
  }

  Future removeAddedSupplier() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("supplierName");
  }

  Future cleanPref() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
  }
}
