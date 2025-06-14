import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_storage.dart';
import 'task_form_screen.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  final _storage = TaskStorage();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    _tasks = await _storage.loadTasks();
    setState(() {});
  }

  Future<void> _saveTasks() async {
    await _storage.saveTasks(_tasks);
  }

  void _addTask() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => const TaskFormScreen()),
    );
    if (newTask != null) {
      setState(() => _tasks.add(newTask));
      _saveTasks();
    }
  }

  void _editTask(Task task) async {
    final editedTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => TaskFormScreen(task: task)),
    );
    if (editedTask != null) {
      setState(() {
        final index = _tasks.indexWhere((t) => t.id == editedTask.id);
        _tasks[index] = editedTask;
      });
      _saveTasks();
    }
  }

  void _toggleComplete(Task task) {
    setState(() => task.isCompleted = !task.isCompleted);
    _saveTasks();
  }

  void _deleteTask(Task task) {
    setState(() => _tasks.removeWhere((t) => t.id == task.id));
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    final pending = _tasks.where((t) => !t.isCompleted).toList();
    final completed = _tasks.where((t) => t.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text("Belum Selesai", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...pending.map((t) => TaskTile(
                task: t,
                onToggle: () => _toggleComplete(t),
                onEdit: () => _editTask(t),
                onDelete: () => _deleteTask(t),
              )),
          const SizedBox(height: 20),
          const Text("Selesai", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...completed.map((t) => TaskTile(
                task: t,
                onToggle: () => _toggleComplete(t),
                onEdit: () => _editTask(t),
                onDelete: () => _deleteTask(t),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
