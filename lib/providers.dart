import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateProvider<ThemeMode>(
  (ref) => ThemeMode.system,
);

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<String>>(
  (ref) => TaskListNotifier(),
);

class TaskListNotifier extends StateNotifier<List<String>> {
  TaskListNotifier() : super([]);
  List<String> tasks = [];

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('tasks') ?? [];
  }

  Future<void> saveTask(String task) async {
    final prefs = await SharedPreferences.getInstance();
    state = [...state, task];
    await prefs.setStringList('tasks', state);
  }

  Future<void> removeTask(int index) async {
    final newList = [...state];
    newList.removeAt(index);
    state = newList;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', state);
  }
}
