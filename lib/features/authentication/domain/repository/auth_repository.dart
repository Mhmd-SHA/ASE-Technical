import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<void> saveUser(User user);
}
