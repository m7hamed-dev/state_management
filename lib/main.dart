import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/dao/user_api.dart';
import 'package:state_management/models/user_model.dart';
import 'package:state_management/providers/user_provider.dart';
import 'package:state_management/ui/home_view.dart';

import 'ui/users_view.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(
          users: UserApi()
              .getUsers(columns: columns, query: query)
              .then((value) async {
            return value;
          }),
          user: User(
            id: 0,
            name: 'name',
            username: 'username',
            email: 'email',
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: UserListScreen(),
      // home: const UserFormScreen(),
    );
  }
}
