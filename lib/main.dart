import 'package:flutter/material.dart';
import 'package:afrifounders_project/home_page.dart';
import 'package:afrifounders_project/providers.dart';
import 'package:afrifounders_project/theme.dart';
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
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
