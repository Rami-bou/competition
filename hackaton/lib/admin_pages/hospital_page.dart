import 'package:flutter/material.dart';

class HospitalsPage extends StatefulWidget {
  const HospitalsPage({super.key});

  @override
  State<HospitalsPage> createState() => _HospitalsPageState();
}

class _HospitalsPageState extends State<HospitalsPage> {
  final List<Map<String, dynamic>> hospitals = [
    {'name': 'Hospital 1', 'icon': Icons.local_hospital},
    {'name': 'Hospital 2', 'icon': Icons.local_hospital},
    {'name': 'Hospital 3', 'icon': Icons.local_hospital},
  ];

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospitals'),
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              hospitals[index]['icon'],
              color: Theme.of(context).primaryColor,
            ),
            title: Text(hospitals[index]['name']),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteHospital(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHospitalDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddHospitalDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Hospital'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Hospital Name',
                  hintText: 'Enter hospital name',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Hospital password',
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addHospital,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addHospital() {
    if (_textController.text.trim().isNotEmpty) {
      setState(() {
        hospitals.add({
          'name': _textController.text.trim(),
          'icon': Icons.local_hospital,
        });
      });
      _textController.clear();
      Navigator.pop(context);
    }
  }

  void _deleteHospital(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
              'Are you sure you want to delete ${hospitals[index]['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  hospitals.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}