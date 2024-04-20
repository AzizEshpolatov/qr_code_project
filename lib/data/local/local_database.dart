import 'package:flutter/cupertino.dart';
import 'package:qr_code_project/data/models/product_constants.dart';
import 'package:qr_code_project/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("products.db");
      return _database!;
    }
  }

  Future<Database> _init(String databaseName) async {
    String internalPath = await getDatabasesPath();
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE ${ProductModelConstants.tableName} (
    ${ProductModelConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${ProductModelConstants.name} TEXT NOT NULL,
    ${ProductModelConstants.description} TEXT NOT NULL,
    ${ProductModelConstants.dateTime} TEXT NOT NULL,
    ${ProductModelConstants.qrCode} TEXT NOT NULL
  )
''');
  }

  static Future<ProductModel> insertProduct(ProductModel productModel) async {
    debugPrint('---------------------|Save Product|------------------------');
    debugPrint("INITIAL ID:${productModel.id}");
    final db = await LocalDatabase().database;
    int savedProductID =
        await db.insert(ProductModelConstants.tableName, productModel.toJson());
    debugPrint("SAVED ID:$savedProductID");
    return productModel.copyWith(id: savedProductID);
  }

  static Future<List<ProductModel>> getAllProducts() async {
    debugPrint(
        '---------------------|Get All Products|------------------------');
    final db = await LocalDatabase().database;
    String orderBy = "${ProductModelConstants.id} DESC";
    List<Map<String, dynamic>> json =
        await db.query(ProductModelConstants.tableName, orderBy: orderBy);
    return json.map((e) => ProductModel.fromJson(e)).toList();
  }

  static Future<int> deleteProduct(int id) async {
    debugPrint('---------------------|Delete Product|------------------------');
    final db = await databaseInstance.database;
    int deletedId = await db.delete(
      ProductModelConstants.tableName,
      where: "${ProductModelConstants.id} = ?",
      whereArgs: [id],
    );
    return deletedId;
  }
}
