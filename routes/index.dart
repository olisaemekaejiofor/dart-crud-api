import 'dart:async';
import 'dart:io';

import 'package:crud_api/db_source.dart';
import 'package:crud_api/models/product_model.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
      return _post(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.put:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context) async {
  final productRepository = context.read<ProductDataSource>();
  final product = await productRepository.fetchProducts();
  return Response.json(body: product);
}

Future<Response> _post(RequestContext context) async {
  final productRepository = context.read<ProductDataSource>();
  final product = Product.fromJson(await context.request.json());

  return Response.json(
    statusCode: HttpStatus.created,
    body: await productRepository.createProduct(product),
  );
}
