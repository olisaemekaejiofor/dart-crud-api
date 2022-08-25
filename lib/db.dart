// ignore_for_file: public_member_api_docs

import 'package:mysql_client/mysql_client.dart';

class ProductMysqlClient {
  factory ProductMysqlClient() {
    return _inst;
  }
  ProductMysqlClient._internal() {
    _connect();
  }

  static final ProductMysqlClient _inst = ProductMysqlClient._internal();

  MySQLConnection? _connection;

  Future<void> _connect() async {
    _connection = await MySQLConnection.createConnection(
      secure: false,
      host: 'localhost',
      port: 3306,
      userName: 'root',
      databaseName: 'my_db',
      password: 'passworded',
    );
    await _connection?.connect();
  }

  Future<IResultSet> execute(
    String query, {
    Map<String, dynamic>? params,
    bool iterable = false,
  }) async {
    if (_connection == null || _connection?.connected == false) {
      await _connect();
    }
    if (_connection?.connected == false) {
      throw Exception('Could not connect to the database');
    }
    return _connection!.execute(query, params, iterable);
  }
}
