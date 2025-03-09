import 'dart:convert';

class User {
  final String id;
  final String firstName;
  final String lastName;

  User({required this.id, required this.firstName, required this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );}

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
      };
    }

  // Helper method to create a Messages object from a JSON string
  static User fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return User.fromJson(json);
  }

  // Helper method to convert a Messages object into a JSON string
  String toJsonString() {
    final Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }
}
