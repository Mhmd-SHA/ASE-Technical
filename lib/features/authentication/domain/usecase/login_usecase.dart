import '../../data/repository/auth_repository_impl.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String username, String password) async {
    final user = await repository.login(username, password);
    await repository.saveUser(user);
    return user;
  }
}
