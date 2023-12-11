import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app_alpha/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppRouter(),
    ),
  );
}
