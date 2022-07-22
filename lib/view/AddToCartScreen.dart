import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/Notifier/AddToCartProvider.dart';
import 'package:gift_registry_flutter/Product/AddToCartItem.dart';
import 'package:gift_registry_flutter/db/ProductListDataHelper.dart';
import 'package:gift_registry_flutter/model/ProductList.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';



class AddToCartScreen extends StatefulWidget {

  static var routeName = '/AddToCart';
  @override
  State<StatefulWidget> createState() {

    return AddToCartState();
  }
}

class AddToCartState extends State<AddToCartScreen> {
  List<ProductList> dbCartList = [];
  final dbHelper = ProductListDatabaseHelper.instance;
   var totalprice ;
  @override
  Widget build(BuildContext context) {
    final cartListProvider = Provider.of<AddToCartProvider>(
        context, listen: false);
    final cartList = cartListProvider.items;
    final price = getTotalPrice();
    cartList.then((cart) {
      setState(() {
        this.dbCartList = cart;
        this.totalprice = price;
      });
    });
    debugPrint(" db data : " + dbCartList.toString());
    return Scaffold(
      appBar: AppBar(title: Text("Cart"),),
      body: Center(
        child: ListView.builder
          (padding: const EdgeInsets.all(20.0),
          itemCount: dbCartList.length,
          itemBuilder: (context, i) =>
              ChangeNotifierProvider<AddToCartProvider>(
                  create: (context) => AddToCartProvider(),
                  child: AddToCartItem(
                    dbCartList.elementAt(i)
                  )),
        ),
      ),
    bottomNavigationBar: BottomAppBar(
        child:Container(
            padding: EdgeInsets.only(top: 20),
          child : Text("Total Price "+ totalprice.toString(), textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
        )
      )
    )
    );
  }

  int getTotalPrice()  {
      int price = 0;
      for (int index = 0; index < dbCartList.length; index++) {
        price = price + (dbCartList[index].productCount * dbCartList[index].price);
      }
      debugPrint(" total price: " + price.toString());
      return price;
    }
  }





