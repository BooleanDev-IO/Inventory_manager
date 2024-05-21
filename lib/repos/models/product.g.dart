// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      categoryId: json['category_id'] as int,
      price: (json['product_price'] as num).toDouble(),
      quantity: json['product_quantity'] as int,
      description: json['product_description'] as String,
      productPartner: ProductPartner.fromJson(json['product_partner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'category_id': instance.categoryId,
      'product_price': instance.price,
      'product_quantity': instance.quantity,
      'product_description': instance.description,
      'product_partner': instance.productPartner,
    };

ProductPartner _$ProductPartnerFromJson(Map<String, dynamic> json) => ProductPartner(
      partnerId: json['partner_id'] as int,
      partnerName: json['partner_name'] as String,
      partnerPhoneNumber: json['partner_phonenumber'] as String,
    );

Map<String, dynamic> _$ProductPartnerToJson(ProductPartner instance) => <String, dynamic>{
      'partner_name': instance.partnerName,
      'partner_phonenumber': instance.partnerPhoneNumber,
      'partner_id': instance.partnerId,
    };
