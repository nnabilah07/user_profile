import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;
  final String imageUrl;
  final String phone;
  final String gender;
  final String nationality;
  final String city;
  final String country;

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phone,
    required this.gender,
    required this.nationality,
    required this.city,
    required this.country,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: "${json['name']['title']} ${json['name']['first']} ${json['name']['last']}",
      email: json['email'],
      imageUrl: json['picture']['large'],
      phone: json['phone'],
      gender: _capitalize(json['gender']),
      nationality: json['nat'],
      city: json['location']['city'],
      country: json['location']['country'],
    );
  }

  static String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  static Future<User> fetchRandomUser() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final user = User.fromJson(jsonResponse['results'][0]);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
