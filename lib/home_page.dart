import 'package:afrifounders_project/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load tasks from SharedPreferences when widget initializes
    Future.microtask(
      () => ref.read(taskListProvider.notifier).loadTasks(),
    );
  }

  void addTask() {
    final userInput = controller.text.trim();
    if (userInput.isEmpty) return;
    ref.read(taskListProvider.notifier).saveTask(userInput);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // final taskListNotifier = ref.watch(taskListProvider.notifier);
    final taskList = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AfriFounders Startup Studio Project"),
      ),
      body: Column(
        children: [
          const Divider(thickness: 2),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length, // add this to avoid infinite builder calls
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(taskList[index]),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      ref.watch(taskListProvider.notifier).removeTask(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade400, // slightly lighter purple
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              taskList[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                            size: 16,
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // lets it go higher
            builder: (context) {
              // String inputText = '';
              return Padding(
                padding: const EdgeInsets.only(
                  // bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      // onChanged: (value) => inputText = value,
                      onSubmitted: (_) {
                        addTask();
                        Navigator.pop(context);
                      },
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter text...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        addTask();
                        print("You entered: ${controller.text}");
                        Navigator.pop(context);
                      },
                      child: const Text('Add Task'),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              );
            },
          );
        },
        child: const Text(
          "+",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
