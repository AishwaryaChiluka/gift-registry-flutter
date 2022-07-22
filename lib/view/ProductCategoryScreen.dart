import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/db/ProductListDataHelper.dart';
import 'package:gift_registry_flutter/model/ProductList.dart';
import 'package:gift_registry_flutter/repo/ProductListRepo.dart';
import 'package:gift_registry_flutter/view/Wishlist.dart';
import '../Model/ProductCategory.dart';
import '../Product/ProductCategoryItem.dart';
import 'AddToCartScreen.dart';


class ProductCategory extends StatelessWidget{
  static String routeName = '/ProductCategory';
  List<Product> productsCategory = [
    Product(
      id: '1',
      title: 'Electronics',
      imageUrl:
      'https://images.pexels.com/photos/356056/pexels-photo-356056.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Product(
      id: '2',
      title: 'Women',
      imageUrl:
      'https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Product(
      id: '3',
      title: 'Baby & Kids',
      imageUrl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: '4',
      title: 'Men',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    saveProductDetails();
   return Scaffold(
       body: Center( child:  GridView.builder
         (padding: const EdgeInsets.all(10.0),
         itemCount: productsCategory.length,
         itemBuilder: (context, i) => ProductCategoryItem(productsCategory[i].id,
           productsCategory[i].title,
           productsCategory[i].imageUrl,),
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2,
           childAspectRatio: 3 / 2,
           crossAxisSpacing: 10,
           mainAxisSpacing: 10,
         ),
       )
       ),
         appBar: AppBar(
           title: Text('Gift Registry'),
           backgroundColor: Colors.blueAccent,
           actions: [
             IconButton(
               onPressed: () {
                 Navigator.pushNamed(context, WishListScreen.routeName,
                    arguments : "WishList");
               },
               icon: Icon(Icons.favorite,color: Colors.white,),
             ),
             IconButton(
               onPressed: () {
                 Navigator.pushNamed(context, AddToCartScreen.routeName,arguments: "Cart");
               },
               icon: Icon(Icons.add_shopping_cart,color: Colors.white,),
             ),
           ],
         ),
       );
   }
  Future<void> saveProductDetails() async {
    final dbHelper = ProductListDatabaseHelper.instance;
    List<ProductList> list =  await dbHelper.getProductList();
    if(list!=null && list.length==0){
      var repo = ProductListRepo().insertProductDetails();}
  }
}