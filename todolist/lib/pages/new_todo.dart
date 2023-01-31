import 'package:flutter/material.dart';
import 'package:todolist/manager/storage.dart';
import 'package:todolist/model/todo.dart';

import 'package:todolist/tool/color.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({Key? key}) : super(key: key);

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  FocusNode _titleFocusNode = FocusNode();
  FocusNode _descFocusNode = FocusNode();

  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _descController = TextEditingController();

  TodoModel? todo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    todo = ModalRoute.of(context)?.settings.arguments as TodoModel;

    _titleController.text = todo?.title ?? "";

    _descController.text = todo?.subTitle ?? "";

    return WillPopScope(
      onWillPop: () {
        FocusScope.of(context).requestFocus(_titleFocusNode);
        FocusScope.of(context).requestFocus(_descFocusNode);

        _saveTodo();
        Navigator.pop(context, todo);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(todo?.belongTo ?? ""),
        ),
        body: Container(
          color: CustomColors.mainBgColor,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                maxLines: 1,
                keyboardAppearance: Brightness.dark,
                textInputAction: TextInputAction.newline,
                cursorColor: CustomColors.orangeColor,
                decoration: InputDecoration(
                  hintText: "请输入标题",
                  hintStyle: TextStyle(
                      color: CustomColors.subTitleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  contentPadding: EdgeInsets.all(10.0),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.solid)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.solid)),
                ),
                onChanged: _onChanged,
                onEditingComplete: _onEidtingComplete,
                onSubmitted: _onSubmitted,
              ),
              TextField(
                controller: _descController,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                minLines: 6,
                maxLines: 12,
                keyboardAppearance: Brightness.dark,
                textInputAction: TextInputAction.newline,
                cursorColor: CustomColors.orangeColor,
                decoration: InputDecoration(
                  hintText: "描述",
                  hintStyle: TextStyle(
                      color: CustomColors.subTitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  contentPadding: EdgeInsets.all(10.0),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.solid)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.solid)),
                ),
                onChanged: _onChanged,
                onEditingComplete: _onEidtingComplete,
                onSubmitted: _onSubmitted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onChanged(String value) {
    print("_onChanged");
  }

  void _onEidtingComplete() {
    print("_onEidtingComplete");
  }

  void _onSubmitted(String value) {
    print("_onSubmitted");
    // _saveTodo();
  }

  void _saveTodo() {
    String title = _titleController.text;
    String desc = _descController.text;

    if (todo != null) {
      todo?.title = title;
      todo?.subTitle = desc;
    } else {
      TodoModel model = TodoModel(belongTo: "", title: title, subTitle: desc);
      todo = model;
    }
  }
}
