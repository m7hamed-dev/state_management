import 'package:state_management/dao/user_api.dart';
import 'package:state_management/models/user_model.dart';

class UserRepository {
  final userDao = UserApi(); // Use UserDao(); for SQLite

  Future getUsers({required String query}) =>
      userDao.getUsers(query: query, columns: []);

  Future getUser(int id) => userDao.getUser(id: id, columns: []);

  Future createUser(User user) => userDao.createUser(user);

  Future updateUser(User user) => userDao.updateUser(user);

  Future deleteUser(int id) => userDao.deleteUser(id);
}
