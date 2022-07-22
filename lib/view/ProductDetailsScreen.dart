import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/Notifier/AddToCartProvider.dart';
import 'package:gift_registry_flutter/Notifier/WishListProvider.dart';
import 'package:gift_registry_flutter/model/ProductList.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget{
  static String routeName = '/ProductDetails';

  @override
  Widget build(BuildContext context) {
    var  addingTocart = Provider.of<AddToCartProvider>(context, listen: false);
    final wishlistProvider =
    Provider.of<WishListProvider>(context, listen: false);
    final productDetail =
    ModalRoute.of(context)?.settings.arguments as ProductList;
    return Scaffold(
        appBar: AppBar( title: Text(productDetail.name),),
    body:   Center(
      child : Padding( padding:const EdgeInsets.all(20),
        child : Column(
            children: [
              ClipRect(
                child: SizedBox.fromSize(// Image radius
                  child: Image.network(
                    productDetail.imageUrl,
                    fit: BoxFit.fill,
                    width: 500,
                    height: 300,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
               child : Align(
                  alignment: Alignment.topLeft,
                  child :  Text(productDetail.brand + productDetail.name,style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),), ),
              ),
              Text(productDetail.description,style: TextStyle(color: Colors.black, fontSize: 16,),),
      Container(
          padding: const EdgeInsets.all(10.0),
           child :  Align(
                  alignment: Alignment.topLeft,
               child :   Text("RS "+productDetail.price.toString(),style: TextStyle(color: Colors.black, fontSize: 16,),)
              )
      )

            ]
        ),
      )

    ),
    bottomNavigationBar: BottomAppBar(
      child: Padding( padding:const EdgeInsets.all(20),
      child  : new Row(
        children: <Widget>[
          Expanded(
            child:  OutlinedButton(onPressed: () {
              var validate = wishlistProvider.checkIsFavourite(productDetail.isfavourite);
              productDetail.isfavourite = validate;
              wishlistProvider.addToWishList(productDetail);
            }, child: Text("Wishlist"),),
            flex: 2,
          ),
          Expanded(
            child:  OutlinedButton(onPressed: () {
              productDetail.productCount = productDetail.productCount+1;
              addingTocart.addToCart(productDetail);
            }, child: Text("Add To Cart"),),
            flex: 2,
          ),
        ],
      ),)
    ),
    );

  }
}