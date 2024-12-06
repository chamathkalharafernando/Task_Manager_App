import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../models/task_model.dart';
import '../view_models/task_view_model.dart';
import 'package:iconsax/iconsax.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task? task;
  TaskDetailScreen({this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFF34495E),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C3E50),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: FadeInDown(
          child: Text(
            widget.task == null ? 'New Task' : 'Edit Task',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: FadeInUp(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Color(0xFFBDC3C7)),
                      filled: true,
                      fillColor: Color(0xFF2C3E50),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Iconsax.text, color: Color(0xFF1ABC9C)),
                    ),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter a title' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Color(0xFFBDC3C7)),
                      filled: true,
                      fillColor: Color(0xFF2C3E50),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          Icon(Iconsax.document_text, color: Color(0xFF1ABC9C)),
                    ),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter a description'
                        : null,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1ABC9C),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    icon: Icon(Iconsax.tick_square, color: Colors.white),
                    label: Text(
                      'Save Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () => _saveTask(taskViewModel),
                  ),
                  if (widget.task != null) SizedBox(height: 16),
                  if (widget.task != null)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE74C3C),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: Icon(Iconsax.trash, color: Colors.white),
                      label: Text(
                        'Delete Task',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => _deleteTask(taskViewModel),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveTask(TaskViewModel taskViewModel) async {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: widget.task?.id,
        title: _titleController.text,
        description: _descriptionController.text,
      );
      try {
        if (widget.task == null) {
          await taskViewModel.addTask(task);
          Navigator.pop(context);
          _showSuccessDialog('Task added successfully.');
        } else {
          await taskViewModel.updateTask(task);
          Navigator.pop(context);
          _showSuccessDialog('Task updated successfully.');
        }
      } catch (error) {
        _showErrorDialog('An error occurred while saving the task.');
      }
    }
  }

  Future<void> _deleteTask(TaskViewModel taskViewModel) async {
    showDialog(
      context: context,
      builder: (context) => FadeInUp(
        child: AlertDialog(
          backgroundColor: Color(0xFF2C3E50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Iconsax.warning_2, color: Color(0xFFE74C3C)),
              SizedBox(width: 8),
              Text(
                'Delete Task',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete this task?',
            style: TextStyle(color: Color(0xFFBDC3C7)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFFBDC3C7)),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await taskViewModel.deleteTask(widget.task!);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  _showSuccessDialog('Task deleted successfully.');
                } catch (error) {
                  Navigator.pop(context);
                  _showErrorDialog(
                      'An error occurred while deleting the task.');
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Color(0xFFE74C3C)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => FadeInUp(
        child: AlertDialog(
          backgroundColor: Color(0xFF2C3E50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Iconsax.tick_circle, color: Color(0xFF1ABC9C)),
              SizedBox(width: 8),
              Text(
                'Success',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(color: Color(0xFFBDC3C7)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Color(0xFF1ABC9C)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => FadeInUp(
        child: AlertDialog(
          backgroundColor: Color(0xFF2C3E50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Iconsax.danger, color: Color(0xFFE74C3C)),
              SizedBox(width: 8),
              Text(
                'Error',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(color: Color(0xFFBDC3C7)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Color(0xFFE74C3C)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
