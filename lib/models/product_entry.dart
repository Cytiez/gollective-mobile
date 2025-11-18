// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
    int id;
    String name;
    int price;
    String description;
    String thumbnail;
    Category category;
    CategoryDisplay categoryDisplay;
    bool isFeatured;
    String clubName;
    String season;
    int releaseYear;
    String condition;
    bool authenticity;
    int? userId;

    Products({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.categoryDisplay,
        required this.isFeatured,
        required this.clubName,
        required this.season,
        required this.releaseYear,
        required this.condition,
        required this.authenticity,
        required this.userId,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: categoryValues.map[json["category"]]!,
        categoryDisplay: categoryDisplayValues.map[json["category_display"]]!,
        isFeatured: json["is_featured"],
        clubName: json["club_name"],
        season: json["season"],
        releaseYear: json["release_year"],
        condition: json["condition"],
        authenticity: json["authenticity"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": categoryValues.reverse[category],
        "category_display": categoryDisplayValues.reverse[categoryDisplay],
        "is_featured": isFeatured,
        "club_name": clubName,
        "season": season,
        "release_year": releaseYear,
        "condition": condition,
        "authenticity": authenticity,
        "user_id": userId,
    };
}

enum Category {
    AWAY,
    HOME,
    THIRD
}

final categoryValues = EnumValues({
    "away": Category.AWAY,
    "home": Category.HOME,
    "third": Category.THIRD
});

enum CategoryDisplay {
    AWAY_JERSEY,
    HOME_JERSEY,
    THIRD_JERSEY
}

final categoryDisplayValues = EnumValues({
    "Away Jersey": CategoryDisplay.AWAY_JERSEY,
    "Home Jersey": CategoryDisplay.HOME_JERSEY,
    "Third Jersey": CategoryDisplay.THIRD_JERSEY
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
