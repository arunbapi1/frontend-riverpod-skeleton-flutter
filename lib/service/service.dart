import 'dart:convert';
import 'package:architecture_demo/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // Future<List<Data>> getUsers() async {
  Future<List<Data>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      print(response.statusCode);
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => Data.fromJson(e))).toList();

      // return result.map((e) => Data.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final userProvider = Provider<ApiServices>((ref) => ApiServices());
