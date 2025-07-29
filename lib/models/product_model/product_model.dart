import 'package:equatable/equatable.dart';

import 'favourit_product.dart';
import 'purchase_table.dart';

class ProductModel extends Equatable {
  final String? productId;
  final DateTime? createdAt;
  final String? productName;
  final String? price;
  final String? oldPrice;
  final String? description;
  final String? category;
  final String? sale;
  final String? imageUrl;
  final List<FavouritProduct>? favouritProducts;
  final List<PurchaseTable>? purchaseTable;

  const ProductModel({
    this.productId,
    this.createdAt,
    this.productName,
    this.price,
    this.oldPrice,
    this.description,
    this.category,
    this.sale,
    this.imageUrl,
    this.favouritProducts,
    this.purchaseTable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: json['product_id'] as String?,
    createdAt:
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
    productName: json['product_name'] as String?,
    price: json['price'] as String?,
    oldPrice: json['old_price'] as String?,
    description: json['description'] as String?,
    category: json['category'] as String?,
    sale: json['sale'] as String?,
    imageUrl: json['image_url'] as String?,
    favouritProducts:
        (json['favourit_products'] as List<dynamic>?)
            ?.map((e) => FavouritProduct.fromJson(e as Map<String, dynamic>))
            .toList(),
    purchaseTable:
        (json['purchase_table'] as List<dynamic>?)
            ?.map((e) => PurchaseTable.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'created_at': createdAt?.toIso8601String(),
    'product_name': productName,
    'price': price,
    'old_price': oldPrice,
    'description': description,
    'category': category,
    'sale': sale,
    'image_url': imageUrl,
    'favourit_products': favouritProducts?.map((e) => e.toJson()).toList(),
    'purchase_table': purchaseTable?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props {
    return [
      productId,
      createdAt,
      productName,
      price,
      oldPrice,
      description,
      category,
      sale,
      imageUrl,
      favouritProducts,
      purchaseTable,
    ];
  }
}
