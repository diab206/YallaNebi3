import 'package:equatable/equatable.dart';

class FavouritProduct extends Equatable {
  final String? id;
  final String? forUser;
  final DateTime? createdAt;
  final String? forProduct;
  final bool? isFavourit;

  const FavouritProduct({
    this.id,
    this.forUser,
    this.createdAt,
    this.forProduct,
    this.isFavourit,
  });

  factory FavouritProduct.fromJson(Map<String, dynamic> json) {
    return FavouritProduct(
      id: json['id'] as String?,
      forUser: json['for_user'] as String?,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      forProduct: json['for_product'] as String?,
      isFavourit: json['is_favourit'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'for_user': forUser,
    'created_at': createdAt?.toIso8601String(),
    'for_product': forProduct,
    'is_favourit': isFavourit,
  };

  @override
  List<Object?> get props {
    return [id, forUser, createdAt, forProduct, isFavourit];
  }
}
