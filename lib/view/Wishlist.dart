import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/Notifier/WishListProvider.dart';
import 'package:gift_registry_flutter/Product/WishListItem.dart';
import 'package:gift_registry_flutter/model/ProductList.dart';
import 'package:provider/provider.dart';
import '../db/ProductListDataHelper.dart';

class WishListScreen extends StatefulWidget {

  static String routeName = '/WishListScreen';
  @override
  State<StatefulWidget> createState() {

    return WishListState();
  }
}
class WishListState extends State<WishListScreen> {

  List<ProductList> dbWishList = [];
  final dbHelper = ProductListDatabaseHelper.instance;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider =
        Provider.of<WishListProvider>(context, listen: false);
    final wishlist = wishlistProvider.items;
    debugPrint("products : " + wishlist.toString());
    wishlist.then((list) {
      setState(() {
        this.dbWishList = list;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("WishList"),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: dbWishList.length,
          itemBuilder: (context, i) =>
              ChangeNotifierProvider<WishListProvider>(
                  create: (context) => WishListProvider(),
                  child: WishListItem(
                    dbWishList.elementAt(i)
                  )),
        ),
      ),
    );
  }


}