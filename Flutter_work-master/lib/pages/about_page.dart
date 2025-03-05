import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_model.dart'; // Import the DataModel

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<DataModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('About us')),
      body: dataModel.entries.isEmpty
          ? const Center(child: Text('No entries added yet.'))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('RegNo')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: dataModel.entries
                    .asMap()
                    .entries
                    .map(
                      (entry) => DataRow(
                        cells: [
                          DataCell(Text(entry.value['name'] ?? '')),
                          DataCell(Text(entry.value['regno'] ?? '')),
                          DataCell(
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => dataModel.deleteEntry(entry.key),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}