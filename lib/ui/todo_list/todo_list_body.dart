import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_state.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_view_model.dart';

class TodoListBody extends StatefulWidget {
  final TodoListState _state;
  final TodoListViewModel _viewModel;
  final Function(Todo)? _onTodoTap;

  const TodoListBody({
    super.key,
    required TodoListState state,
    required TodoListViewModel viewModel,
    Function(Todo)? onTodoTap,
  }): _state = state,
        _viewModel = viewModel,
        _onTodoTap = onTodoTap;

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
    final viewModel = widget._viewModel;
    final state = widget._state;
    final todoList = state.todoList;

    if(todoList == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return buildTodoList(
      todoList,
      onTap: widget._onTodoTap,
      onDelete: (id) => viewModel.deleteTodo(id),
    );
  }

  ListView buildTodoList(
    List<Todo> todoList, {
    Function(Todo)? onTap,
    Function(int id)? onDelete,
  }) {
    final cards = <Widget>[];

    for(var todo in todoList) {
      final card = buildTodoCard(
        todo,
        onTap: onTap,
        onDelete: onDelete,
      );
      cards.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: card,
      ));
    }

    return ListView.builder(
      itemCount: cards.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => cards[index],
    );
  }

  Card buildTodoCard(
    Todo todo, {
    Function(Todo)? onTap,
    Function(int id)? onDelete,
  }) {
    return Card(
      child: ListTile(
        title: Text(todo.title),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        subtitle: Text(todo.memo),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () { if(onDelete != null) onDelete(todo.id!); },
        ),
        onTap: () { if(onTap != null) onTap(todo); },
      ),
    );
  }
}
