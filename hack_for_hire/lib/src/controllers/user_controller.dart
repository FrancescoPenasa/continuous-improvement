
import 'dart:convert';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserController {
  late final UserRepository _userRepository;

  UserController({required UserRepository userRepository}) : _userRepository = userRepository;

  Future<User> getUser() async {
    final response = await _userRepository.getUser();
    final data = jsonDecode(response.body);

    User user = User.fromJson(data);

    return user;
  }
}