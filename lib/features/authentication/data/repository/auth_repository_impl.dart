import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/local/local_data_source.dart';
import '../data_source/remote/remote_data_source.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;
  final DatabaseService databaseService;

  AuthRepositoryImpl(this.apiService, this.databaseService);

  @override
  Future<User> login(String username, String password) async {
    return await apiService.login(username, password);
  }

  @override
  Future<void> saveUser(User user) async {
    await databaseService.insertUser(user as UserModel);
  }
}
