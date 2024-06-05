class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'id = $id, name = $name, description =  $description, price = $price, imageUrl = $imageUrl';
  }

  @override 
  bool operator ==(covariant ProductDataModel other){
    return id == other.id && name == other.name;
  }
  
  @override
  int get hashCode => id.hashCode;
  
}
