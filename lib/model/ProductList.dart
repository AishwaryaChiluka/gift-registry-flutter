import 'package:flutter/cupertino.dart';

class ProductList extends ChangeNotifier {


   String productID =" ";
   String name ="";
   String description =" ";
   int price = 0;
   String imageUrl = " ";
   String rating = " ";
   String category =" ";
   String brand =" ";
   int productCount = 0;
   bool isfavourite = false;


  ProductList({
    required this.productID,
    required this.price ,
    required this.rating ,
    required this.imageUrl,
    required this.category ,
    required this.name ,
    required this.brand ,
    required this.description,
    required this.productCount,
    required this.isfavourite
  });



  String get getProductId => this.productID;

  String get getName => this.name;

  String get getDescripion => this.description;

   int get getPrice => this.price;

  String get getImageUrl => this.imageUrl;

  String get getRating => this.rating;

  String get getCategory => this.category;

  String get getBrand => this.brand;

  int get getProductCount => this.productCount;



  // Convert a product object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this.productID != null) {
      map['productID'] = this.productID;
    }

    map['name'] = this.name;
    map['description'] = this.description;
    map['price'] = this.price;
    map['imageUrl'] = this.imageUrl;
    map['category'] = this.category;
    map['rating'] = this.rating;
    map['brand'] = this.brand;
    map['ProductCount'] = this.productCount;
    map['isfavourite'] = this.isfavourite;
    return map;
  }


  // Extract a product object from a Map object
  ProductList.fromMapObject(Map<String, dynamic> map) {
    bool flag = (map['isfavourite'] == 1)? true : false;
    this.productID = map['productID'];
    this.name = map['name'];
    this.description = map['description'];
    this.price = map['price'];
    this.imageUrl = map['imageUrl'];
    this.category = map['category'];
    this.rating = map['rating'];
    this.brand = map['brand'];
    this.productCount = map['ProductCount'];
    this.isfavourite = flag;
  }

  ProductList.fromproductCountObject(Map<String, dynamic> map){
    this.productCount = map['ProductCount'] ;
  }

}

