import 'dart:io';

import 'package:crud_api/db.dart';
import 'package:dart_frog/dart_frog.dart';

final mysqlClient = ProductMysqlClient();

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler.use(databaseHandler()), ip, port);
}

Middleware databaseHandler() {
  return (handler) {
    return handler.use(provider<ProductMysqlClient>((context) => mysqlClient));
  };
}
