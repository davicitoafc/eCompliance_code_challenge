import 'package:e_compliance/bloc/user_bloc.dart';
import 'package:e_compliance/model/user.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const _serviceUrl = 'https://5ca369c58bae720014a9623e.mockapi.io/data';

  static Future getUsers() async {
    try {
      final response = await http.get(_serviceUrl);
      await Future.delayed(Duration(seconds: 2));

      String content = response.body;
      List collection = json.decode(content);
      List<User> _users =
          collection.map((json) => User.fromJson(json)).toList();
      return _users;
    } catch (e) {
      print('Server Exception!!!');
      return e;
    }
  }
}
