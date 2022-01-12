import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/user_model.dart';
import 'package:state_management/providers/user_provider.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({Key? key}) : super(key: key);

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(userProvider.user == null ? 'Add' : 'Edit' + ' User'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<UserProvider>(
              builder: (context, state, _) {
                User user = state.user;
                _nameController.value =
                    _nameController.value.copyWith(text: user.name);
                _usernameController.value =
                    _usernameController.value.copyWith(text: user.username);
                _emailController.value =
                    _emailController.value.copyWith(text: user.email);
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          controller: _nameController,
                          onChanged: (value) {
                            user.name = value;
                          },
                          validator: (value) {
                            // if (value.length < 1) {
                            //   return 'Name cannot be empty';
                            // }
                            // return null;
                          }),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                          ),
                          controller: _usernameController,
                          onChanged: (value) {
                            user.username = value;
                          },
                          validator: (value) {
                            // if (value.length < 1) {
                            //   return 'Username cannot be empty';
                            // }
                            // return null;
                          }),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          controller: _emailController,
                          onChanged: (value) {
                            user.email = value;
                          },
                          validator: (value) {
                            // if (value.length < 1) {
                            //   return 'Email cannot be empty';
                            // }
                            // return null;
                          }),
                      RaisedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            user.id == null
                                ? userProvider.createUser(user)
                                : userProvider.updateUser(user);
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
