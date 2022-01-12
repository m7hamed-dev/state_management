import 'package:flutter/material.dart';
import 'package:state_management/models/user_model.dart';
import 'package:state_management/repos/user_repo.dart';

class UserProvider with ChangeNotifier {
  final _userRepository = UserRepository();
  late List<User> users;
  late User user;
  late User prevUser;

  UserProvider({required this.users, required this.user});

  getUsers() => users;
  setUsers(List<User> users) => this.users = users;

  getUser() => user;
  setUser(User user) => this.user = user;

  Future<void> fetchUsers({required String query}) async {
    debugPrint('userProvider');
    users = await _userRepository.getUsers(query: query);
    for (var item in users) {
      debugPrint('item = ${item.name}');
    }
    notifyListeners();
  }

  Future<void> fetchUser({required User user}) async {
    this.user = await _userRepository.getUser(user.id);
    prevUser = user;
    notifyListeners();
  }

  Future<void> createUser(User user) async {
    users.add(await _userRepository.createUser(user));
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    this.user = await _userRepository.updateUser(user);
    users[users.indexOf(prevUser)] = this.user;
    notifyListeners();
  }

  Future<void> deleteUser(User user) async {
    await _userRepository.deleteUser(user.id);
    users.removeAt(users.indexOf(user));
    notifyListeners();
  }
}
