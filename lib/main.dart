import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Users(),
      child: MaterialApp(
        title: 'Flutter CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (_) => const UserList(),
          AppRoutes.USER_FORM: (_) => UserForm(),
        },
      ),
    );
  }
}
