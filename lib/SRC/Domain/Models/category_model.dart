class CategoryModel {
  String? id;
  final String name;
  final String description;
  String? image;
  final String? status; // Added status field

  CategoryModel({
    this.id,
    required this.name,
    required this.description,
    this.image,
    required this.status, // Added status to constructor
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'status': status, // Added status to toDocument
    };
  }
}
