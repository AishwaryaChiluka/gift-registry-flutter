import 'package:flutter/material.dart';

import '../db/ProductListDataHelper.dart';
import '../model/ProductList.dart';
class ProductListProvider extends ChangeNotifier{
  var products = [];
  final dbHelper = ProductListDatabaseHelper.instance;





  Future<List<ProductList>> findByCategory(String productCategory) async {
    List<ProductList> list =  await dbHelper.getProductByCategory(productCategory);
    products.addAll(list);
    notifyListeners();
    return list;

  }

  Future<List<ProductList>> findProductById(String id) async {
    var result =  await dbHelper.getProduct(id);
    notifyListeners();
    return result;
  }




}