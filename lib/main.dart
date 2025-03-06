import 'package:flutter/material.dart';
import 'package:untitled10/user_form.dart';
import 'package:untitled10/user_list.dart';
import 'package:untitled10/user_provider.dart';
import 'package:untitled10/user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: UserForm(),
        routes: {
          "/create": (_) => UserForm(),
          "/list": (_) => UserList(),
          "/view": (_) => UserView(),
        },
      ),
    );
  }
}
