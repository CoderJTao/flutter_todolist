import 'package:flutter/material.dart';
import 'package:todolist/manager/storage.dart';
import 'package:todolist/tool/color.dart';
import '../model/todo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Text(AppStorage().currentListType),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _drawerKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
          color: CustomColors.themeColor,
          child: _buildList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .pushNamed("create",
                  arguments: TodoModel(belongTo: AppStorage().currentListType))
              .then((value) {
            TodoModel model = value as TodoModel;
            if (model.title.isNotEmpty || model.subTitle.isNotEmpty) {
              setState(() {
                AppStorage().addTodo(model);
              });
            }
          });
        },
        tooltip: 'Increment',
        backgroundColor: CustomColors.orangeColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(""),
        // ),
        body: Container(
          // padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
          color: CustomColors.secondBgColor,
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              height: 1,
              color: CustomColors.mainBgColor,
            ),
            itemCount: AppStorage().showList.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) {
                return _buildDrawerHeader();
              } else {
                TodoListModel listModel = AppStorage().showList[i - 1];

                return _buildDrawerItem(listModel);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Row(
      children: [
        Container(
          height: 80,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 20, 15),
            child: CircleAvatar(
              backgroundImage: const AssetImage('lib/images/avatar_01.png'),
              radius: 25.0,
            ),
          ),
        ),
        Text(
          "即将成为型男的男人",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget _buildDrawerItem(TodoListModel listModel) {
    return GestureDetector(
      child: Container(
        height: 60,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: listModel.isSelected ? Colors.redAccent : Colors.white,
            ),
            Padding(padding: EdgeInsets.only(left: 8)),
            Text(listModel.title,
                style: TextStyle(
                    color:
                        listModel.isSelected ? Colors.redAccent : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            Spacer(),
            Text("${listModel.unCheckedCount()}",
                style: TextStyle(
                    color:
                        listModel.isSelected ? Colors.redAccent : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400))
          ],
        ),
      ),
      onTap: () {
        AppStorage().changeToList(listModel);
        _drawerKey.currentState?.closeDrawer();
        setState(() {});
      },
    );
  }

  Widget _buildList() {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              height: 1,
              color: CustomColors.mainBgColor,
            ),
        itemCount: AppStorage().currentList().length,
        itemBuilder: (context, i) {
          var item = AppStorage().currentList()[i];
          if (item is TodoModel) {
            return _buildItem(AppStorage().currentList()[i]);
          } else {
            return _buildHeader(item);
          }
        });
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: const TextStyle(
            color: CustomColors.subTitleColor,
            fontSize: 14,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _buildItem(TodoModel model) {
    return GestureDetector(
      child: Container(
        color: CustomColors.secondBgColor,
        child: Row(
          children: [
            Container(
              child: Checkbox(
                  value: model.isChecked,
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    return CustomColors.checkBoxColor;
                  }),
                  onChanged: (value) {
                    setState(() {
                      model.isChecked = value!;
                    });
                    // Future.delayed(const Duration(seconds: 1), (){
                    //   setState(() {
                    //     _todos.remove(model);
                    //   });
                    // });
                  }),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title.isNotEmpty ? model.title : "无标题",
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  model.subTitle.isNotEmpty ? model.subTitle : "无描述",
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: CustomColors.subTitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                )
              ],
            ))
          ],
        ),
      ),
      onTap: () async {
        await Navigator.of(context)
            .pushNamed("create", arguments: model)
            .then((value) {
          TodoModel target = value as TodoModel;
          if (target.title.isNotEmpty || target.subTitle.isNotEmpty) {
            setState(() {
              AppStorage().updateTodo(target);
            });
          }
        });
      },
    );
  }
}
