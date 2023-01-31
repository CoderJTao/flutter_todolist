import 'package:flutter/material.dart';
import 'package:todolist/pages/login.dart';
import 'package:todolist/pages/new_todo.dart';
import 'package:todolist/pages/regist.dart';
import 'package:todolist/pages/resetpwd.dart';
import 'package:todolist/tool/color.dart';

import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: CustomColors.themeColor,
            backgroundColor: Colors.black12),
        initialRoute: "login", //名为"/"的路由作为应用的home(首页)
        routes: _managerRoutes());
  }

  Map<String, WidgetBuilder> _managerRoutes() {
    return {
      "login": (context) => const LoginPage(),
      "regist": (context) => const RegistPage(),
      "reset": (context) => const ResetPwdPage(),
      "home": (context) => const MyHomePage(title: 'Todo-list'), //注册首页路由
      "create": (context) => const CreateTodoPage(), //新建Todo
    };
  }
}
