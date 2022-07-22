import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/db/ProductListDataHelper.dart';
import 'package:gift_registry_flutter/model/ProductList.dart';


class AddToCartProvider extends ChangeNotifier{
  List<ProductList> cartItems = [];
  final dbHelper = ProductListDatabaseHelper.instance;

  addToCart(ProductList productList) async {
    int? updateCount = await dbHelper.update(productList);
    if (updateCount != 0) { // Success
      debugPrint("Added to Cart succesfully" );
    } else { // Failure
      debugPrint("Added to Cart failed : " );
    }
    notifyListeners();
  }

  Future<List<ProductList>> get items async{
    cartItems.clear();
    var result =  await dbHelper.getProductList();
    for(int index =0 ; index < result.length ; index++) {
      if (result
          .elementAt(index)
          .productCount > 0){
        cartItems.add(result.elementAt(index));}
    }
   // totalPrice = totalPrice + productList.price;
    return [...cartItems];
  }

  deleteCartItem(ProductList productList  ) async{
    int? updateCount = await dbHelper.update(productList);
    if (productList.productCount ==0 || productList.productCount<0) { // Success
      debugPrint("deleting one item from Cart succesfully" );
    } else { // Failure
      debugPrint("deleted one item from Cart failed  " );
    }
    notifyListeners();
  }




}