import 'package:flutter/material.dart';
import '../Model/ProductCategory.dart';
import '../db/ProductListDataHelper.dart';
import '../model/ProductList.dart';
import '../repo/ProductListRepo.dart';
import '../view/ProductListScreen.dart';

class ProductCategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductCategoryItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        elevation: 10.0,
        shadowColor: Colors.black12,
    child :  GridTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
           Expanded( child : GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductListScreen.routeName,
                    arguments: title);
              },
              child: ClipRect(
                child: SizedBox.fromSize(// Image radius
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
            ),
            Container(
             child : Text(title, style: TextStyle(color: Colors.black, fontSize: 16,),),
            )
          ],
        ),
      ),
      ),
    );
  }


}