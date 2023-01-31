import 'dart:convert';

class TodoModel {
  String title;
  String subTitle;
  bool isChecked;
  String belongTo;

  TodoModel(
      {required this.belongTo,
      this.title = "",
      this.subTitle = "",
      this.isChecked = false});

  bool isEqualTo(TodoModel model) {
    return title == model.title &&
        subTitle == model.subTitle &&
        belongTo == model.belongTo &&
        isChecked == model.isChecked;
  }

  TodoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? "",
        subTitle = json['subTitle'] ?? "",
        isChecked = json['isChecked'] ?? false,
        belongTo = json['belongTo'] ?? "";

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "isChecked": isChecked,
        "belongTo": belongTo
      };
}

class TodoListModel {
  String title;
  bool isSelected = false;
  List<TodoModel> todosList = [];

  TodoListModel(
      {required this.title, required this.todosList, this.isSelected = false});

  int unCheckedCount() {
    int result = 0;

    for (TodoModel model in todosList) {
      if (!model.isChecked) {
        result++;
      }
    }
    return result;
  }
}
