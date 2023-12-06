import 'package:flutter/material.dart';

class OneLineTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String? _label;
  final String? _hint;
  final Function(String)? _onChanged;
  final Function()? _onClear;

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
