part of 'models.dart';

enum FoodType { new_food, popular, recommended }

class Food extends Equatable {
  final int? id;
  final String? picturePath;
  final String? name;
  final String? description;
  final String? ingredients;
  final int? price;
  final double? rate;
  final List<FoodType>? types;

  Food({
    this.id,
    this.picturePath,
    this.name,
    this.description,
    this.ingredients,
    this.price,
    this.rate,
    this.types,
  });

  @override
  List<Object?> get props =>
      [id, picturePath, name, ingredients, price, rate, types];
}

List<Food> mockFoods = [
  Food(
      id: 1,
      picturePath:
          "https://i.pinimg.com/originals/42/2c/19/422c19005a5226ed6d173fc0890da392.jpg",
      name: "Sate Sayur",
      description: "Iya kek gitu se la",
      ingredients: "Bawang Merah, Paprika,",
      price: 150000,
      rate: 4.2,
      types: [FoodType.new_food, FoodType.popular]),
  Food(
      id: 2,
      picturePath:
          "http://weneedfun.com/wp-content/uploads/2015/09/Cute-baby-girl-pics-for-facebook-profile-18.jpg",
      name: "Sate Sayur",
      description: "Iya kek gitu se la",
      ingredients: "Bawang Merah, Paprika,",
      price: 150000,
      rate: 4.2,
      types: [FoodType.new_food, FoodType.popular, FoodType.recommended]),
  Food(
      id: 3,
      picturePath:
          "http://weneedfun.com/wp-content/uploads/2015/09/Cute-baby-girl-pics-for-facebook-profile-18.jpg",
      name: "Sate Sayur",
      description: "Iya kek gitu se la",
      ingredients: "Bawang Merah, Paprika,",
      price: 150000,
      rate: 4.2,
      types: [FoodType.new_food, FoodType.popular]),
  Food(
      id: 4,
      picturePath:
          "http://weneedfun.com/wp-content/uploads/2015/09/Cute-baby-girl-pics-for-facebook-profile-18.jpg",
      name: "Sate Sayur",
      description: "Iya kek gitu se la",
      ingredients: "Bawang Merah, Paprika,",
      price: 150000,
      rate: 4.2,
      types: [FoodType.new_food])
];
