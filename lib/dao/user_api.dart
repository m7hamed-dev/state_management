import 'package:dio/dio.dart';
import 'package:state_management/config/constants.dart';
import 'package:state_management/models/user_model.dart';

class UserApi {
  static String mainUrl = Constants.baseUrl;
  static String userModel = '/users';

  static BaseOptions options = BaseOptions(
    baseUrl: mainUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  Future<List<User>> getUsers(
      {required List<String> columns, required String query}) async {
    try {
      Map<String, dynamic> params =
          (query != null && query != '') ? {'name': query} : {};
      Response response = await dio.get(userModel, queryParameters: params);

      List result = response.data as List;
      List<User> users = result.isNotEmpty
          ? result.map((user) => User.fromJson(user)).toList()
          : [];

      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<User> getUser({required List<String> columns, required int id}) async {
    try {
      Response response = await dio.get(userModel, queryParameters: {'id': id});

      List result = response.data as List;
      List<User> users = result.isNotEmpty
          ? result.map((user) => User.fromJson(user)).toList()
          : [];
      User user = users.isNotEmpty
          ? users[0]
          : User(id: id, name: '', username: 'username', email: 'email');

      return user;
    } catch (e) {
      print(e);
      return User(id: id, name: '', username: 'username', email: 'email');
    }
  }

  Future<User> createUser(User user) async {
    try {
      Response response = await dio.post(userModel, data: user.toJson());

      user = User.fromJson(response.data);

      return user;
    } catch (e) {
      // print(e);
      return User(id: 0, name: '', username: 'username', email: 'email');
    }
  }

  Future<User> updateUser(User user) async {
    try {
      Response response = await dio.post(userModel,
          data: user.toJson(), queryParameters: {'id': user.id});

      user = User.fromJson(response.data);

      return user;
    } catch (e) {
      print(e);
      return User(id: 0, name: '', username: 'username', email: 'email');
    }
  }

  Future deleteUser(int id) async {
    try {
      await dio.get(userModel, queryParameters: {'id': id});
      print(id.toString() + ' deleted');
    } catch (e) {
      print(e);
    }
  }
}
