import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/Notifier/AddToCartProvider.dart';
import 'package:gift_registry_flutter/Notifier/WishListProvider.dart';
import 'package:gift_registry_flutter/model/ProductList.dart';
import 'package:share_plus/share_plus.dart';

import '../Notifier/ProductListProvider.dart';
import '../view/ProductDetailsScreen.dart';
import 'package:provider/provider.dart';


class ProductListItem extends StatefulWidget {

  final ProductList productList;
  ProductListItem(this.productList);
  @override
  State<StatefulWidget> createState() {

    return ProductListItemState();
  }
}
class ProductListItemState extends State<ProductListItem>{

  @override
  Widget build(BuildContext context) {
  var  addingTocart = Provider.of<AddToCartProvider>(context, listen: false);
  final wishlistProvider =
  Provider.of<WishListProvider>(context, listen: false);
    return GestureDetector (
        onTap: (){
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: widget.productList );
        },
        child : Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0,5.0,0,5.0),
                  child :
                  Align(
                      alignment: Alignment.centerLeft,
                      child : Text(widget.productList.name,style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),))
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0,5.0,0,5.0),
                 child :  Align(
                     alignment: Alignment.centerLeft, child : Text(widget.productList.brand,style: TextStyle(color: Colors.black, fontSize: 12,)))
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0,5.0,0,5.0),
                    child :  Align(
                        alignment: Alignment.centerLeft, child :  Text("RS ${widget.productList.price}",style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,)))
                ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(widget.productList.isfavourite?Icons.favorite : Icons.favorite_border),
                          color: Colors.red,
                          iconSize: 20,
                          onPressed: (){
                            var validate = wishlistProvider.checkIsFavourite(widget.productList.isfavourite);
                            widget.productList.isfavourite = validate;
                            wishlistProvider.addToWishList(widget.productList);

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.share,color: Colors.red,),
                          iconSize: 20,
                          onPressed: (){
                            var productUrl = "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=sspa_dk_detail_0?ie=UTF8&adId=A080235872J0I9BJGW7K&qualifier=1655704521&id=3088988748269439&widgetName=sp_detail_thematic&url=%2Fdp%2FB08VB57558%2Fref%3Dsspa_dk_detail_0%3Fpsc%3D1%26pd_rd_i%3DB08VB57558%26pd_rd_w%3DXFS9n%26content-id%3Damzn1.sym.c78e9690-8742-4ec1-b9f9-3b21d8be9837%26pf_rd_p%3Dc78e9690-8742-4ec1-b9f9-3b21d8be9837%26pf_rd_r%3DXRB747558DV831219CZT%26pd_rd_wg%3DstEB2%26pd_rd_r%3D8bb2bc1b-ac94-4d65-af1a-923d9fa29092%26s%3Delectronics&sp_csd=d2lkZ2V0TmFtZT1zcF9kZXRhaWxfdGhlbWF0aWM";
                            Share.share('${widget.productList.name}\n\n$productUrl');
                          }
                        )
                        ]

                  )
              ]),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ClipRect(
                      child: SizedBox.fromSize(// Image radius
                        child: Image.network(
                          widget.productList.imageUrl,
                          fit: BoxFit.fill,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    OutlinedButton(
                    onPressed: (){
                      widget.productList.productCount = widget.productList.productCount+1;
                      addingTocart.addToCart(widget.productList);
    },
                    style: ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    ),
    child: const Icon(Icons.add_shopping_cart,color : Colors.red),
    )
                    ]
              )
        ]))
    );
  }



}
