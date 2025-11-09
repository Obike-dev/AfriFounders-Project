import 'package:afrifounders_project/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SimpleToDoApp(),
    ),
  );
}

class SimpleToDoApp extends ConsumerWidget {
  const SimpleToDoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
