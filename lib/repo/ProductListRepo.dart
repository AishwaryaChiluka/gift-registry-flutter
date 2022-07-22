import 'package:flutter/cupertino.dart';

import '../db/ProductListDataHelper.dart';
import '../model/ProductList.dart';

class ProductListRepo{
  List<ProductList> _productItems = [
    ProductList(
        productID: "5f265c841625bbccf7cf810c",
        price: 369,
        rating: "1.6",
        imageUrl: "https://cdn.pixabay.com/photo/2012/04/26/18/44/watch-42803_960_720.png",
        category: "Electronics",
        name: "Ecratic",
        brand: "LabKart",
        description: "When you want to look your very best, Philips has the right grooming solution for you. The new Philips 3000 series trimmers capture more low lying hair for efficient, even trimming results, so you can easily achieve the 3-day stubble, short beard or long beard look you want.",
        productCount : 0,
        isfavourite : false
    ),
    ProductList(productID: "5f265c846f776287684dc398"
        , price: 133,
        rating:  "2.2",
        imageUrl: "https://cdn.pixabay.com/photo/2017/03/19/11/08/bangle-2156210__340.jpg",
        category: "Women",
        name: "Webiotic",
        brand: "LP",
        description: "Hi, I am your complete solution to take care of your baby from top to toe and even from the mosquitoes. Buy me as a combo for your baby or gift this amazing combo of certified toxin-free products to a friend. The kit comes packed in an amazing waterproof bag with lots of space to carry your baby stuff around.",
        productCount : 0,
        isfavourite : false
    ),
    ProductList(productID: "5f265c84b9266a3f50120e26"
        , price: 302,
        rating:  "2.4",
        imageUrl: "https://cdn.pixabay.com/photo/2014/06/02/14/27/saree-360372__340.jpg",
        category: "Women",
        name: "Singavera",
        brand: "LabKart",
        description: "Beautifully handmade laptop case/sleeve made in the Nepal Himalaya. It can be slipped inside your backpack or carried alone with space for all your work bits and pieces!",
        productCount : 0,
        isfavourite : false
    ),
    ProductList(productID: "5f265c8475f711c4bf8dc845"
        , price: 233,
        rating:  " 3.4",
        imageUrl: "https://cdn.pixabay.com/photo/2017/02/26/21/39/rose-2101475__340.jpg",
        category: "Baby & Kids",
        name: "Genmom",
        brand: "Basics",
        description: "Hi, I am your complete solution to take care of your baby from top to toe and even from the mosquitoes. Buy me as a combo for your baby or gift this amazing combo of certified toxin-free products to a friend. The kit comes packed in an amazing waterproof bag with lots of space to carry your baby stuff around.",
        productCount : 0,
        isfavourite : false
    ),

    ProductList(productID: "5f265c84012d806b22c5e6a9"
        , price: 302,
        rating:  " 1.7",
        imageUrl: "https://cdn.pixabay.com/photo/2013/07/13/12/15/cooking-pot-159470__340.png",
        category: "Electronics",
        name: "Firewax",
        brand: "Basics",
        description: "Beautifully handmade laptop case/sleeve made in the Nepal Himalaya. It can be slipped inside your backpack or carried alone with space for all your work bits and pieces!",
        productCount : 0,
        isfavourite : false
    ),
    ProductList(productID: "5f265c842069686df7fc247a"
        , price: 345,
        rating:  "1.5",
        imageUrl: "https://cdn.pixabay.com/photo/2017/11/09/16/21/bangles-2933988__340.jpg",
        category: "Women",
        name: "Ebidco",
        brand: "LabKart",
        description: "Beautifully handmade laptop case/sleeve made in the Nepal Himalaya. It can be slipped inside your backpack or carried alone with space for all your work bits and pieces!",
        productCount : 0,
        isfavourite : false
    ),
    ProductList(productID: "5f265c840f7ef80a75853b61"
        , price: 269,
        rating:  "4.4",
        imageUrl: "https://cdn.pixabay.com/photo/2015/01/07/18/11/shirts-591750__340.jpg",
        category: "Men",
        name: "shirt",
        brand: "PE",
        description: "Hi, I am your complete solution to take care of your baby from top to toe and even from the mosquitoes. Buy me as a combo for your baby or gift this amazing combo of certified toxin-free products to a friend. The kit comes packed in an amazing waterproof bag with lots of space to carry your baby stuff around.",
        productCount : 0,
        isfavourite : false
    ),
    ProductList(productID: "5f265c840f7ef80a75853b62"
        , price: 269,
        rating:  "4.4",
        imageUrl: "https://cdn.pixabay.com/photo/2015/09/23/03/07/menswear-952836_960_720.jpg",
        category: "Men",
        name: "Letpro",
        brand: "PE",
        description: "Hi, I am your complete solution to take care of your baby from top to toe and even from the mosquitoes. Buy me as a combo for your baby or gift this amazing combo of certified toxin-free products to a friend. The kit comes packed in an amazing waterproof bag with lots of space to carry your baby stuff around.",
        productCount : 0,
        isfavourite : false
    ),
    ProductList(productID: "5f265c8475f711c4bf8dc846"
        , price: 233,
        rating:  " 3.4",
        imageUrl: "https://media.istockphoto.com/photos/toy-and-diapers-picture-id636802462?s=612x612",
        category: "Baby & Kids",
        name: "Toy",
        brand: "Basics",
        description: "Hi, I am your complete solution to take care of your baby from top to toe and even from the mosquitoes. Buy me as a combo for your baby or gift this amazing combo of certified toxin-free products to a friend. The kit comes packed in an amazing waterproof bag with lots of space to carry your baby stuff around.",
        productCount : 0,
        isfavourite : false
    ),
  ];
  insertProductDetails() async {
    final dbHelper = ProductListDatabaseHelper.instance;
    for(int index = 0 ; index < _productItems.length ;index++) {
      int? result = await dbHelper.insert(_productItems[index]);
      if (result != 0) { // SuccessFuture<bool>
        debugPrint("inserted Success: " + _productItems[index].toString());
      } else { // Failure
        debugPrint("inserted failed : " + _productItems[index].toString());
      }
    }
  }
  findByCategory(String category) async {
    var productList = _productItems.where((prod) => prod.category == category).toList();
    final dbHelper = ProductListDatabaseHelper.instance;
    var result =  await dbHelper.getProductByCategory(category);
    return result;
  }

  Future<List<ProductList>> findProductById(String id) async {
    final dbHelper = ProductListDatabaseHelper.instance;
    var result =  await dbHelper.getProduct(id);
    return result;
  }



  ProductListRepo();
}