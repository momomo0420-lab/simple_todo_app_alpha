import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_state.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_view_model.dart';

/// Todoリスト画面の本体
class TodoListBody extends StatefulWidget {
  // 状態
  final TodoListState _state;
  // ビューモデル
  final TodoListViewModel _viewModel;
  // Todoが押下された場合の動作
  final Function(Todo)? _onTodoTap;

  /// Todoリスト画面の本体を生成する。
  ///
  /// [viewModel]と[state]を使用し、表示させる内容やボタン押下時の処理などを決定する。
  /// またTodo押下時、[onTodoTap]を実行する。
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

    // 初回描画時にTodoリストを読み込んでおく。
    widget._viewModel.loadTodoList();
  }

  @override
  Widget build(BuildContext context) {
    // ビューモデル
    final viewModel = widget._viewModel;
    // 状態
    final state = widget._state;
    // Todoリスト
    final todoList = state.todoList;
    // Todo押下時の動作
    final onTodoTap = widget._onTodoTap;

    // Todoの読み込みが完了していない場合はグルグルを表示する。
    if(todoList == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Todoリストを表示する。
    return _buildTodoList(
      todoList,
      onTap: onTodoTap,
      onDelete: (id) => viewModel.deleteTodo(id),
    );
  }

  /// Todoリストを作成する。
  ///
  /// [todoList]の情報を使用し、ListViewウィジェットを作成する。
  /// またTodo押下時は[onTap]を、削除アイコン押下時は[onDelete]を実行する。
  ListView _buildTodoList(
    List<Todo> todoList, {
    Function(Todo)? onTap,
    Function(int id)? onDelete,
  }) {
    final cards = <Widget>[];

    // Todoリストを1件ずつカードリストに変換する。
    for(var todo in todoList) {
      final card = _buildTodoCard(
        todo,
        onTap: onTap,
        onDelete: onDelete,
      );
      cards.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: card,
      ));
    }

    // カードリストをリストビューに変換する。
    return ListView.builder(
      itemCount: cards.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => cards[index],
    );
  }

  /// Todoカードを作成する。
  ///
  /// [todo]を使用し、カードを作成する。
  /// またTodo押下時は[onTap]を、削除アイコン押下時は[onDelete]を実行する。
  Card _buildTodoCard(
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
