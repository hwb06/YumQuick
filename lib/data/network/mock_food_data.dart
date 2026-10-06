import '../../helpers/app_assets.dart';

class MockFoodData {
  MockFoodData._();

  static const List<Map<String, dynamic>> _extraFoods = [
    {'id': 'f9', 'name': 'Chocolate Cupcake', 'description': 'Soft cupcake with creamy frosting', 'price': 6.5, 'rating': 4.5, 'image': AppAssets.cupCake, 'categoryId': 'dessert'},
    {'id': 'f10', 'name': 'Mango Smoothie', 'description': 'Fresh mango blended with yoghurt', 'price': 5.0, 'rating': 4.4, 'image': 'assets/images/drink.png', 'categoryId': 'drinks'},
  ];

  static List<Map<String, dynamic>> get allFoods => [
    ...(home['bestSellers'] as List).cast<Map<String, dynamic>>(),
    ...(home['recommended'] as List).cast<Map<String, dynamic>>(),
    ..._extraFoods,
  ];

  static const Map<String, String> optionsTitle = {
    'snacks': 'Toppings',
    'meal': 'Add on ingredients',
    'vegan': 'Add on ingredients',
    'dessert': 'Toppings',
    'drinks': 'Add ons',
  };

  static const Map<String, List<Map<String, dynamic>>> toppingsByCategory = {
    'snacks': [
      {'id': 't1', 'name': 'Guacamole', 'price': 2.99},
      {'id': 't2', 'name': 'Jalapeños', 'price': 3.99},
      {'id': 't3', 'name': 'Ground Beef', 'price': 4.99},
      {'id': 't4', 'name': 'Pico de Gallo', 'price': 1.99},
    ],
    'meal': [
      {'id': 't5', 'name': 'Shrimp', 'price': 2.99},
      {'id': 't6', 'name': 'Crisp Onion', 'price': 1.99},
      {'id': 't7', 'name': 'Sweet Corn', 'price': 1.99},
      {'id': 't8', 'name': 'Extra Cheese', 'price': 2.49},
    ],
    'vegan': [
      {'id': 't9', 'name': 'Vegan Mayo', 'price': 2.99},
      {'id': 't10', 'name': 'Sliced Tomatoes', 'price': 1.99},
      {'id': 't11', 'name': 'Whole Wheat Bun', 'price': 3.00},
      {'id': 't12', 'name': 'Bell Peppers', 'price': 1.50},
    ],
    'dessert': [
      {'id': 't13', 'name': 'Chocolate Chips', 'price': 1.50},
      {'id': 't14', 'name': 'Whipped Cream', 'price': 1.00},
      {'id': 't15', 'name': 'Sprinkles', 'price': 0.75},
    ],
    'drinks': [
      {'id': 't16', 'name': 'Extra Shot', 'price': 1.50},
      {'id': 't17', 'name': 'Whipped Cream', 'price': 1.00},
      {'id': 't18', 'name': 'Caramel Drizzle', 'price': 1.25},
    ],
  };

  static Map<String, dynamic>? detail(String id) {
    for (final f in allFoods) {
      if (f['id'] == id) {
        final cat = f['categoryId'] as String;
        return {
          ...f,
          'optionsTitle': optionsTitle[cat] ?? 'Add ons',
          'toppings': toppingsByCategory[cat] ?? const [],
        };
      }
    }
    return null;
  }

  static const Map<String, dynamic> home = {

    'categories': [
      {'id': 'snacks', 'name': 'Snacks', 'icon': AppAssets.icSnack},
      {'id': 'meal', 'name': 'Meal', 'icon': AppAssets.icMeal},
      {'id': 'vegan', 'name': 'Vegan', 'icon': AppAssets.icVegan},
      {'id': 'dessert', 'name': 'Dessert', 'icon': AppAssets.icDessert},
      {'id': 'drinks', 'name': 'Drinks', 'icon': AppAssets.icDrinks},
    ],
    'bestSellers': [
      {'id': 'f1', 'name': 'Salmon Sushi', 'description': 'Fresh salmon rolls', 'price': 103.0, 'rating': 4.9, 'image': AppAssets.sushi, 'categoryId': 'meal'},
      {'id': 'f2', 'name': 'Chicken Curry', 'description': 'Spicy home-style curry', 'price': 50.0, 'rating': 4.8, 'image': AppAssets.curry, 'categoryId': 'meal'},
      {'id': 'f3', 'name': 'Lasagna', 'description': 'Cheesy baked lasagna', 'price': 12.99, 'rating': 4.7, 'image': AppAssets.lasagna, 'categoryId': 'vegan'},
      {'id': 'f4', 'name': 'Berry Cupcake', 'description': 'Sweet berry cupcake', 'price': 8.20, 'rating': 4.6, 'image': AppAssets.cupCake, 'categoryId': 'dessert'},
    ],
    'promos': [
      {'id': 'p1', 'title': 'Experience our delicious new dish', 'discount': '30% OFF', 'image': AppAssets.pizza},
      {'id': 'p2', 'title': 'Try our juicy chicken burgers', 'discount': '20% OFF', 'image': AppAssets.burgerOne},
      {'id': 'p3', 'title': 'Fresh and healthy spring rolls', 'discount': '15% OFF', 'image': AppAssets.springRolls},
    ],
    'recommended': [
      {'id': 'f5', 'name': 'Chicken Burger', 'description': 'Grilled chicken with cheese', 'price': 10.0, 'rating': 5.0, 'image': AppAssets.burgerOne, 'categoryId': 'meal'},
      {'id': 'f6', 'name': 'Spring Rolls', 'description': 'Crispy veggie rolls', 'price': 25.0, 'rating': 5.0, 'image': AppAssets.springRolls, 'categoryId': 'vegan'},
      {'id': 'f7', 'name': 'Mexican Appetizer', 'description': 'Tortilla chips with toppings', 'price': 15.0, 'rating': 4.8, 'image': AppAssets.snackOne, 'categoryId': 'snacks'},
      {'id': 'f8', 'name': 'Pork Skewer', 'description': 'Grilled pork skewers', 'price': 12.99, 'rating': 4.7, 'image': AppAssets.snackTwo, 'categoryId': 'snacks'},
    ],
  };
}