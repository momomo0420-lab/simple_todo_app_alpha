import 'package:flutter/material.dart';

/// 一行の入力フォーム
class OneLineTextField extends StatelessWidget {
  // コントローラー
  final TextEditingController _controller;
  // ラベル
  final String? _label;
  // ヒント
  final String? _hint;
  // 入力された際の動作
  final Function(String)? _onChanged;
  // クリアされた際の動作
  final Function()? _onClear;

  /// 一行の入力フォームを生成する。
  ///
  /// [controller]に入力用のコントローラを設定する（必須）。
  /// [label]、[hint]にはフォームに表示されるラベルとヒントを設定する。
  /// [onChanged]は入力された際の動作を登録する。[value]には入力された文字列が渡される。
  /// [onClear]はフォームの文字列がクリアされた際の動作を登録する。
  const OneLineTextField({
    super.key,
    required TextEditingController controller,
    String? label,
    String? hint,
    Function(String value)? onChanged,
    Function()? onClear,
  }): _controller = controller,
        _label = label,
        _hint = hint,
        _onChanged = onChanged,
        _onClear = onClear;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: _controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: _label,
        hintText: _hint,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            _controller.clear();
            if(_onClear != null) _onClear!();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      onChanged: _onChanged,
    );
  }
}
