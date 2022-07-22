import 'package:flutter/material.dart';
import 'package:gift_registry_flutter/Notifier/ProductListProvider.dart';
import 'package:gift_registry_flutter/model/ProductList.dart';
import 'package:provider/provider.dart';
import '../Product/ProductListItem.dart';


class ProductListScreen extends StatefulWidget {
  static String routeName = '/ProductList';

  @override
  State<StatefulWidget> createState() {
    return Products();
  }
}

class Products extends State<ProductListScreen> {
  List<ProductList> products = [];
  var isSearch = false;

  @override
  Widget build(BuildContext context) {
    final productCategory =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final productsData =
        Provider.of<ProductListProvider>(context, listen: false);
    Future<List<ProductList>> futureProducts = productsData.findByCategory(productCategory);
     products = extractproducts(futureProducts);
    if(foundProduct.isEmpty && !isSearch){
      foundProduct = products;}
    debugPrint("products : " + products.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(productCategory),
      ),
      body:SingleChildScrollView(
      scrollDirection: Axis.vertical,
     child : Container( child : Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
               foundProduct.isNotEmpty ? ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
                itemCount: foundProduct.length,
                itemBuilder: (context, i) =>
                    ChangeNotifierProvider<ProductListProvider>(
                        create: (context) => ProductListProvider(),
                        child: ProductListItem(
                          foundProduct.elementAt(i),
                        )),
              ):const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
          ])),
      )
      )
    );
  }

  List<ProductList> foundProduct = [];

  @override
  void initState() {
    foundProduct = products;
    super.initState();
  }

  _runFilter(String value) {
    List<ProductList> results = [];
    if (value.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = products;
    } else {
      results = products
          .where(
              (prod) => prod.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      debugPrint("search : " + results.toString());
      isSearch = true;
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundProduct = results;
    });
  }

  List<ProductList> extractproducts(Future<List<ProductList>> futureProducts) {
    futureProducts.then((products) {
      setState(() {
        this.products = products;
      });
    });
    return products;
  }
}
