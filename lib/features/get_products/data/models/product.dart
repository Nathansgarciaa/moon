import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int? userId;
  final int? id;
  final String title;
  final String body;

  const Product({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
