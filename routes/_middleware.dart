import 'package:crud_api/db.dart';
import 'package:crud_api/db_source.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(injectionHandler());
}

Middleware injectionHandler() {
  return (handler) {
    return handler.use(requestLogger()).use(
          provider<ProductDataSource>(
            (context) => ProductDataSource(context.read<ProductMysqlClient>()),
          ),
        );
  };
}
