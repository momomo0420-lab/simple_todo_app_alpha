import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_state.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_view_model.dart';

class TodoListBody extends StatefulWidget {
  final TodoListState _state;
  final TodoListViewModel _viewModel;
  final Function(int)? _navigateToDetail;

  const TodoListBody({
    super.key,
    required TodoListState state,
    required TodoListViewModel viewModel,
    Function(int id)? navigateToDetail,
  }): _state = state,
        _viewModel = viewModel,
        _navigateToDetail = navigateToDetail;

  @override
  State<TodoListBody> createState() => _TodoListBodyState();
}

class _TodoListBodyState extends State<TodoListBody> {

  @override
  void initState() {
    super.initState();

    widget._viewModel.loadTodoList();
  }

  @override
  Widget build(BuildContext context) {
    final todoList = widget._state.todoList;

    if(todoList == null) {
      return const Center(child: Text('Now Loading...'));
    }

    return buildTodoList(
      todoList,
      onTap: widget._navigateToDetail,
    );
  }

  ListView buildTodoList(
    List<Todo> todoList,
    {Function(int)? onTap}
  ) {
    final tiles = <Widget>[];

    for(var todo in todoList) {
      final tile = buildTodoTile(
        todo: todo,
        onTap: onTap,
      );
      tiles.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: tile,
      ));
    }

    return ListView.builder(
      itemCount: tiles.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => tiles[index],
    );
  }

  ListTile buildTodoTile({
    required Todo todo,
    Function(int)? onTap,
  }) {
    return ListTile(
      title: Text(todo.title),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Text(todo.memo),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        if(onTap != null) onTap(todo.id!);
      },
    );
  }
}
