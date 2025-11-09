import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTask extends ConsumerWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  const EditTask({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Edit task'),
      contentPadding: const EdgeInsets.all(20),
      content: TextField(
        controller: controller,
        onSubmitted: (_) => onSave(),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: 'Edit task',
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: onSave,
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }
}
