import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolist/manager/storage.dart';

import '../tool/color.dart';
import '../widgets/input.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  String _account = "";
  String _password = "";
  String _passwordConfirm = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
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
              InputField(
                title: "",
                hintText: "请再次输入密码",
                onValueChanged: (value) {
                  _passwordConfirm = value;
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
                          '注册',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          AppStorage()
                              .registWithInfo(_account, _password)
                              .then((value) {
                            if (value) {
                              Fluttertoast.showToast(
                                  msg: "注册成功",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "注册失败",
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
              )
            ],
          )),
    );
  }
}
