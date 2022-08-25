// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

class Product {
  Product({
    this.id,
    this.name,
    this.imageUrl,
    this.createdAt,
  });

  factory Product.fromRowAssoc(Map<String, String?> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'] == null ? null : DateTime.tryParse(json['createdAt']!),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toString(),
    };
  }

  final String? id;
  final DateTime? createdAt;
  final String? name;
  final String? imageUrl;
}
