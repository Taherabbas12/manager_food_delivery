class FoodModule {
  String nameFood;
  String description;
  int price;
  String category;
  String quantity; // الكمية
  List<ImageModel> imageURL; // رابط صورة الطعام
  bool isAvailable;

  // Constructor
  FoodModule({
    required this.nameFood,
    required this.description,
    required this.price,
    required this.category,
    required this.quantity,
    required this.imageURL,
    this.isAvailable =
        true, // تم تعيين القيمة الافتراضية لـ isAvailable إلى true
  });

  // Factory method to create FoodModule object from JSON
  factory FoodModule.fromJson(Map<String, dynamic> json) {
    return FoodModule(
      nameFood: json['nameFood'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      quantity: json['quantity'],
      imageURL: json['imageURL'],
      isAvailable: json['isAvailable'] ??
          true, // قد تكون قيمة isAvailable غير موجودة في JSON، لذا قمنا بتعيين القيمة الافتراضية هنا
    );
  }

  // Method to convert FoodModule object to JSON
  Map<String, dynamic> toJson() => {
        'nameFood': nameFood,
        'description': description,
        'price': price,
        'category': category,
        'quantity': quantity,
        'imageURL': imageURL,
        'isAvailable': isAvailable,
      };
}

class ImageModel {
  String imagePath;
  int itemId; // ID of the associated item

  ImageModel({
    required this.imagePath,
    required this.itemId,
  });

  // Factory method to create ImageModel object from JSON
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imagePath: json['imagePath'],
      itemId: json['itemId'],
    );
  }

  // Method to convert ImageModel object to JSON
  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'itemId': itemId,
      };
}
