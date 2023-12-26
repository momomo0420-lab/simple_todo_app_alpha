import 'package:flutter/material.dart';

/// 複数行の入力フォーム
class MultipleLinesTextField extends StatelessWidget {
  // コントローラー
  final TextEditingController _controller;
  // ラベル
  final String? _label;
  // ヒント
  final String? _hint;
  // 文字が入力された際の動作
  final Function(String)? _onChanged;

  /// 複数行の入力フォームを生成する。
  ///
  /// [controller]に入力用のコントローラを設定する（必須）。
  /// [label]、[hint]にフォームに表示されるラベルとヒントを設定する。
  /// [onChanged]は入力された際の動作を登録する。[value]には入力された文字列が渡される。
  const MultipleLinesTextField({
    super.key,
    required TextEditingController controller,
    String? label,
    String? hint,
    Function(String value)? onChanged,
  }): _controller = controller,
        _label = label,
        _hint = hint,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: _controller,
      maxLines: 7,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: _label,
        hintText: _hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: _onChanged,
    );
  }
}
