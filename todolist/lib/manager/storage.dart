import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/model/todo.dart';

class AppStorage {
  AppStorage._internal();

  factory AppStorage() => _instance;

  static late final AppStorage _instance = AppStorage._internal();

  String currentListType = "Today";
  List<TodoListModel> showList = [
    TodoListModel(title: "Today", todosList: [], isSelected: true),
    TodoListModel(title: "Inbox", todosList: [], isSelected: false)
  ];

  List currentList() {
    List<TodoModel> list = [];

    for (TodoListModel item in showList) {
      if (item.title == currentListType) {
        list = item.todosList;
      }
    }

    List<TodoModel> todos = List.empty(growable: true);
    List<TodoModel> done = List.empty(growable: true);
    for (TodoModel item in list) {
      if (item.isChecked) {
        done.add(item);
      } else {
        todos.add(item);
      }
    }
    List result = List.empty(growable: true);
    result.addAll(todos);
    if (done.isNotEmpty) {
      result.add("已完成");
      result.addAll(done);
    }
    return result;
  }

  void changeToList(TodoListModel target) {
    for (TodoListModel model in showList) {
      model.isSelected = false;
      if (model.title == target.title) {
        model.isSelected = true;
        currentListType = model.title;
      }
    }
  }

  void addListType(String listType) {
    showList
        .add(TodoListModel(title: listType, todosList: [], isSelected: false));
  }

  void addTodo(TodoModel model) {
    for (TodoListModel item in showList) {
      if (item.title == currentListType) {
        item.todosList.insert(0, model);
      }
    }

    final modelMap = model.toJson();
    String jsonStr = jsonEncode(modelMap);
    print(jsonStr);
  }

  void updateTodo(TodoModel model) {
    for (TodoListModel item in showList) {
      if (item.title == currentListType) {
        List<TodoModel> useList = List.empty(growable: true);
        for (TodoModel todo in item.todosList) {
          if (todo.isEqualTo(model)) {
            useList.add(model);
          } else {
            useList.add(todo);
          }
        }
        item.todosList = useList;
      }
    }
  }

  Future<bool> registWithInfo(String account, String password) async {
    if (account.length == 0 || password.length == 0) {
      return Future.value(false);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> allAccount = prefs.getKeys().toList();

    if (allAccount.contains(account)) {
      // 已经注册过了
      return Future.value(false);
    } else {
      // 新用户
      prefs.setString(account, password);
      return Future.value(true);
    }
  }

  Future<bool> loginWithInfo(String account, String password) async {
    if (account.length == 0 || password.length == 0) {
      return Future.value(false);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> allAccount = prefs.getKeys().toList();

    if (allAccount.contains(account)) {
      // 已经注册过了
      String? localPwd = prefs.getString(account);
      if (localPwd != null && localPwd == password) {
        // 登录成功
        return Future.value(true);
      } else {
        // 登录失败
        return Future.value(false);
      }
    } else {
      // 新用户
      return Future.value(false);
    }
  }
}
