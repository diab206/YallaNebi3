import 'package:equatable/equatable.dart';

class Rates extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final int? rate;
  final String? forUser;
  final String? forProduct;

  const Rates({
    this.id,
    this.createdAt,
    this.rate,
    this.forUser,
    this.forProduct,
  });

  factory Rates.fromJson(Map<String, dynamic> json) => Rates(
    id: json['id'] as String?,
    createdAt:
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
    rate: json['rate'] as int?,
    forUser: json['for_user'] as String?,
    forProduct: json['for_product'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'rate': rate,
    'for_user': forUser,
    'for_product': forProduct,
  };

  @override
  List<Object?> get props => [id, createdAt, rate, forUser, forProduct];
}
