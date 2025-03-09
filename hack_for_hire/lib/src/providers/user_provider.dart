import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

part 'user_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository();
}



@riverpod
class UserData extends _$UserData {
  @override
  Future<User> build() {
    final userController = UserController(userRepository: UserRepository());
    return userController.getUser();
  }
}

// @riverpod
// class UserControllerNotifier extends _$UserControllerNotifier {
//   late final UserController _userController;
//
//   @override
//   AsyncValue<User?> build() {
//     final userRepository = ref.read(userRepositoryProvider);
//     _userController = UserController(userRepository: userRepository);
//     return const AsyncValue.data(null);
//   }
//
//   Future<void> fetchUser() async {
//     state = const AsyncValue.loading();
//     try {
//       final user = await _userController.getUser();
//       state = AsyncValue.data(user);
//     } catch (e, stack) {
//       state = AsyncValue.error(e, stack);
//     }
//   }
// }
//
