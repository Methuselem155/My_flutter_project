// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'database_helper.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> _addData() async {
    final name = _nameController.text.trim();
    final regNo = _regNoController.text.trim();

    if (name.isEmpty || regNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    await _dbHelper.insertStudent(name, int.parse(regNo));

    _nameController.clear();
    _regNoController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data added successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _regNoController,
              decoration: const InputDecoration(
                labelText: 'RegNo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(onPressed: _addData, child: const Text('Add Data')),
          ],
        ),
      ),
    );
  }
}
