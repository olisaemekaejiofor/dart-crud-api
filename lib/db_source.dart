// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:authentication/db.dart';
import 'package:authentication/models/product_model.dart';

class ProductDataSource {
  ProductDataSource(this._mysqlClient);

  final ProductMysqlClient _mysqlClient;

  Future<List<Product>> fetchProducts() async {
    final result = await _mysqlClient.execute(
      'SELECT * FROM products;',
    );
    final items = <Product>[];
    for (final row in result.rows) {
      items.add(Product.fromRowAssoc(row.assoc()));
    }

    return items;
  }

  Future<List<Product>> fetchProduct(String id) async {
    final result = await _mysqlClient.execute(
      'SELECT * from products WHERE id = $id;',
    );

    final items = <Product>[];
    for (final row in result.rows) {
      items.add(Product.fromRowAssoc(row.assoc()));
    }

    return items;
  }

  Future<String> createProduct(Product product) async {
    await _mysqlClient.execute(
      'INSET INTO products (name, imageUrl, createdAt) VALUES (${product.name}, ${product.imageUrl}, ${product.createdAt});',
    );
    return 'Product created sucessfully';
  }

  Future<String> updateProduct(Product product) async {
    await _mysqlClient.execute(
      'UPDATE products SET name = ${product.name}, imageUrl = ${product.imageUrl} WHERE id = ${product.id};',
    );
    return 'Product updated sucessfully';
  }

  Future<void> deleteProduct(Product product) async {
    await _mysqlClient.execute(
      'DELETE FROM products WHERE id = ${product.id};',
    );
  }
}
