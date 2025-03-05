import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_model.dart'; // Import the DataModel

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final regnoController = TextEditingController();
    final dataModel = Provider.of<DataModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('This is where you add your data')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
            children: [
              SizedBox(
                width: 300, // Set a fixed width for the text fields
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 300, // Set a fixed width for the text fields
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 300, // Set a fixed width for the text fields
                child: TextField(
                  controller: regnoController,
                  decoration: const InputDecoration(
                    labelText: 'RegNo',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty || regnoController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields')),
                    );
                    return;
                  }
                  dataModel.addEntry(nameController.text, regnoController.text);
                  nameController.clear();
                  regnoController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Entry added successfully!')),
                  );
                },
                child: const Text('Add Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}