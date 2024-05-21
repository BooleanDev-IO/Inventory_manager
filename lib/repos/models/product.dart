import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'product_id')
  int productId;

  @JsonKey(name: 'product_name')
  String productName;

  @JsonKey(name: 'category_id')
  int categoryId;

  @JsonKey(name: 'product_price')
  double price;
  @JsonKey(name: 'product_quantity')
  int quantity;
  @JsonKey(name: 'product_description')
  String description;
  @JsonKey(name: 'product_partner')
  ProductPartner productPartner;

  Product({
    required this.productId,
    required this.productName,
    required this.categoryId,
    required this.price,
    required this.quantity,
    required this.description,
    required this.productPartner,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductPartner {
  @JsonKey(name: 'partner_name')
  String partnerName;
  @JsonKey(name: 'partner_phonenumber')
  String partnerPhoneNumber;
  @JsonKey(name: 'partner_id')
  int partnerId;

  ProductPartner({
    required this.partnerId,
    required this.partnerName,
    required this.partnerPhoneNumber,
  });

  factory ProductPartner.fromJson(Map<String, dynamic> json) => _$ProductPartnerFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPartnerToJson(this);
}
