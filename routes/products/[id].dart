// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:io';

import 'package:crud_api/db_source.dart';
import 'package:crud_api/models/product_model.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final productRepository = context.read<ProductDataSource>();
  final product = await productRepository.fetchProduct(id);

  if (product.isEmpty) {
    return Response(statusCode: HttpStatus.notFound, body: 'Not found');
  }
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, product.first);
    case HttpMethod.put:
      return _put(context, id, product.first);
    case HttpMethod.delete:
      return _delete(context, product.first);
    case HttpMethod.head:
    case HttpMethod.post:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, Product product) async {
  return Response.json(body: product);
}

Future<Response> _put(RequestContext context, String id, Product product) async {
  final productRepository = context.read<ProductDataSource>();
  final updatedProduct = Product.fromJson(await context.request.json());
  return Response.json(
    statusCode: HttpStatus.created,
    body: await productRepository.updateProduct(updatedProduct),
  );
}

Future<Response> _delete(RequestContext context, Product product) async {
  final productRepository = context.read<ProductDataSource>();
  await productRepository.deleteProduct(product);

  return Response(statusCode: HttpStatus.noContent);
}
