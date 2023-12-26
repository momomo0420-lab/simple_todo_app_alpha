import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

/// Todoのモデルとなるデータクラス
@freezed
class Todo with _$Todo {
  /// Todo（データクラス）を生成する。
  const factory Todo({
    /// 主キー
    int? id,
    /// タイトル
    @Default('')
    String title,
    /// メモ
    @Default('')
    String memo,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}