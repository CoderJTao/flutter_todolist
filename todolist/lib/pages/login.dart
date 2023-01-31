import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolist/manager/storage.dart';
import 'package:todolist/pages/home.dart';
import 'package:todolist/widgets/input.dart';

import '../tool/color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _account = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
          color: CustomColors.themeColor,
          child: Column(
            children: [
              InputField(
                title: "",
                hintText: "请输入账号",
                onValueChanged: (value) {
                  _account = value;
                },
              ),
              InputField(
                title: "",
                hintText: "请输入密码",
                onValueChanged: (value) {
                  _password = value;
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              CustomColors.orangeColor),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(left: 15, right: 15)),
                        ),
                        child: const Text(
                          '登录',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          AppStorage()
                              .loginWithInfo(_account, _password)
                              .then((value) {
                            if (value) {
                              Fluttertoast.showToast(
                                  msg: "登录成功",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Future.delayed(const Duration(milliseconds: 400),
                                  () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return MyHomePage(title: 'Todo-list');
                                        },
                                        fullscreenDialog: true));
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "登录失败",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(CustomColors.orangeColor),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(left: 15, right: 15)),
                      ),
                      child: const Text(
                        '注册',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Navigator.pushNamed(context, "home");
                        Navigator.of(context).pushNamed("regist");
                      },
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
