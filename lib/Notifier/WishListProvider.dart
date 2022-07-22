import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/db/ProductListDataHelper.dart';
import 'package:gift_registry_flutter/model/ProductList.dart';
class WishListProvider extends ChangeNotifier{

  List<ProductList> wishListItems = [];
  final dbHelper = ProductListDatabaseHelper.instance;

  addToWishList(ProductList productList) async {
    int? updateCount = await dbHelper.update(productList);
    if (updateCount != 0) { // Success
      debugPrint("Added to Wishlist succesfully" );
    } else { // Failure
      debugPrint("Added to Wishlist failed : " );
    }
    notifyListeners();
  }

  Future<List<ProductList>> get items async {
    wishListItems.clear();
    var result =  await dbHelper.getProductList();
    for(int index =0 ; index < result.length ; index++) {
      if (result
          .elementAt(index)
          .isfavourite){
        wishListItems.add(result.elementAt(index));}
    }
    return [...wishListItems];
  }


 bool checkIsFavourite(bool isfavourite) {
    isfavourite = !isfavourite;
    return isfavourite;
  }
}