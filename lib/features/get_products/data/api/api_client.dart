import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/product.dart';

part 'api_client.g.dart'; // Ensure this matches the generated file name

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/posts')
  Future<List<Product>> getProducts();
}
