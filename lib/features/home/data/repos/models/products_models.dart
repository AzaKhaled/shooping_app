class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage; // ✅ تمت الإضافة
  final String thumbnail;
  final double rating;
  final int stock;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage, // ✅
    required this.thumbnail,
    required this.rating,
    required this.stock,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(), // ✅
      thumbnail: json['thumbnail'],
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage, // ✅
      'thumbnail': thumbnail,
      'rating': rating,
      'stock': stock,
      'images': images,
    };
  }

  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    double? discountPercentage, // ✅
    String? thumbnail,
    double? rating,
    int? stock,
    List<String>? images,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage, // ✅
      thumbnail: thumbnail ?? this.thumbnail,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      images: images ?? this.images,
    );
  }
}
