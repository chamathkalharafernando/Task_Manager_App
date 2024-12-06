import 'package:flutter/foundation.dart';
import '../data/task_repository.dart';
import '../models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  final _taskRepository = TaskRepository();

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskRepository.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _taskRepository.insertTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await _taskRepository.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(Task task) async {
    await _taskRepository.deleteTask(task.id!);
    await fetchTasks();
  }
}