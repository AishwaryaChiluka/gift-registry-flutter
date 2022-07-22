import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/ProductList.dart';

class ProductListDatabaseHelper {

  String Table = 'ProductList_table';
  String colProductId = 'productID';
  String colName = 'name';
  String colDescription = 'description';
  String colPrice = 'price';
  String colimagUrl = 'imageUrl';
  String colRating = 'rating';
  String colCategory = 'category';
  String colBarnd = 'brand';
  String colProductCount = 'ProductCount';
  String colIsFavourite = 'isfavourite';



  // make this a singleton class
  ProductListDatabaseHelper._privateConstructor();
  static final ProductListDatabaseHelper instance = ProductListDatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static  Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'ProductList.db';
    return await openDatabase(path,
        version: 1,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $Table ($colProductId TEXT PRIMARY KEY,$colName TEXT,$colDescription TEXT,$colPrice INTEGER,$colimagUrl TEXT,$colRating TEXT,$colCategory TEXT,$colBarnd TEXT,$colProductCount INTEGER,$colIsFavourite INTEGER)');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int?> insert(ProductList productList) async {
    Database? db = await instance.database;
    return await db?.insert(Table, productList.toMap());
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic?>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(Table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic?>>?> queryRows(name) async {
    Database? db = await instance.database;
    return await db?.query(Table, where: "$colName LIKE '%$name%'");
  }




  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int?> update(ProductList productList) async {
    var db = await this.database;
    var result = await db?.update(Table, productList.toMap(), where: '$colProductId = ?', whereArgs: [productList.productID]);
    return result;
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int?> delete(String id) async {
    Database? db = await instance.database;
    return await db?.delete(Table, where: '$colProductId = ?', whereArgs: [id]);
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'ProductList List' [ List<ProductList> ]
  Future<List<ProductList>> getProductList() async {

    var productListMapList = await getProductListMapList(); // Get 'Map List' from database
    int? count = productListMapList?.length;         // Count the number of map entries in db table

    List<ProductList> productList = [];
    // For loop to create a 'AddToCart List' from a 'Map List'
    for (int i = 0; i < count!; i++) {
      productList.add(ProductList.fromMapObject(productListMapList![i]));
    }

    return productList;
  }
  // Fetch Operation: Get all addToCart objects from database
  Future<List<Map<String, dynamic?>>?> getProductListMapList() async {
    Database? db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $addToCart order by $colPriority ASC');
    var result = await db?.query(Table, orderBy: '$colPrice ASC');
    return result;
  }

  Future<List<Map<String, dynamic?>>?> getProductMapList(String productId) async {
    Database? db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $addToCart order by $colPriority ASC');
    var result = await db?.query(Table,  where: '$colProductId = ?', whereArgs: [productId]);
    return result;
  }

  Future<List<ProductList>> getProduct(String productId) async {

    var productMapList = await getProductMapList(productId); // Get 'Map List' from database
    int? count = productMapList?.length;         // Count the number of map entries in db table

    List<ProductList> productList = [];
    // For loop to create a 'AddToCart List' from a 'Map List'
    for (int i = 0; i < count!; i++) {
      productList.add(ProductList.fromMapObject(productMapList![i]));
    }

    return productList;
  }

  Future<List<ProductList>> getProductByCategory(String category) async {

    var productMapList = await getProductByCategoryMapList(category); // Get 'Map List' from database
    int? count = productMapList?.length;         // Count the number of map entries in db table

    List<ProductList> productList = [];
    // For loop to create a 'AddToCart List' from a 'Map List'
    for (int i = 0; i < count!; i++) {
      productList.add(ProductList.fromMapObject(productMapList![i]));
    }

    return productList;
  }
  Future<List<Map<String, dynamic?>>?> getProductByCategoryMapList(String category) async {
    Database? db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $addToCart order by $colPriority ASC');
    var result = await db?.query(Table,  where: '$colCategory = ?', whereArgs: [category]);
    return result;
  }
}