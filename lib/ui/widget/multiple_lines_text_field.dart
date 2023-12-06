import 'package:flutter/material.dart';

class MultipleLinesTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String? _label;
  final String? _hint;
  final Function(String)? _onChanged;

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
