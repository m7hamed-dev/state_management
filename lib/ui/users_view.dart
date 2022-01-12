import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/user_model.dart';
import 'package:state_management/providers/user_provider.dart';

import 'home_view.dart';

class UserListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _searchController = TextEditingController();

  late UserProvider userProvider;

  UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autocorrect: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                userProvider.fetchUsers(query: _searchController.text);
              },
            ),
            hintText: 'Search...',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<UserFormScreen>(
                builder: (context) {
                  return ChangeNotifierProvider.value(
                    value: userProvider
                      ..fetchUser(
                        user: User(
                          id: 0,
                          name: 'name',
                          username: 'username',
                          email: 'email',
                        ),
                      ),
                    child: const UserFormScreen(),
                  );
                },
              ),
            );
          }),
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, state, _) {
            debugPrint('state.users = ${state.users}');
            if (state.users.isEmpty) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  User user = state.users[index];
                  return _userCard(user, context);
                },
              );
            }
            return const Text('no dara');
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }

  Card _userCard(User user, BuildContext context) {
    return Card(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(padding: EdgeInsets.all(10), child: Text(user.name)),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<UserFormScreen>(
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                            value: userProvider..fetchUser(user: user),
                            child: UserFormScreen(),
                          );
                        },
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    userProvider.deleteUser(user);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
