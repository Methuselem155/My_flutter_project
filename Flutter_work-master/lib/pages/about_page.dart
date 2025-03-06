import 'package:flutter/material.dart';
import 'database_helper.dart'; 

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _dataEntries = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _dbHelper.getAllStudents();
    setState(() {
      _dataEntries = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _dataEntries.isEmpty
                ? const Center(child: Text('No data available'))
                : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Student Name')),
                      DataColumn(label: Text('Reg num')),
                    ],
                    rows:
                        _dataEntries.map((entry) {
                          return DataRow(
                            cells: [
                              DataCell(Text(entry['studentName'])),
                              DataCell(Text(entry['studentAge'].toString())),
                            ],
                          );
                        }).toList(),
                  ),
                ),
      ),
    );
  }
}
