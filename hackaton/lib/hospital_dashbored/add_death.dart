import 'package:flutter/material.dart';

class DeathRecordsPage extends StatefulWidget {
  const DeathRecordsPage({super.key});

  @override
  State<DeathRecordsPage> createState() => _DeathRecordsPageState();
}

class _DeathRecordsPageState extends State<DeathRecordsPage> {
  final List<Map<String, dynamic>> deaths = [
    {
      'name': 'John Doe',
      'date': '2023-05-15',
      'cause': 'Cardiac Arrest',
      'icon': Icons.person_off
    },
    {
      'name': 'Jane Smith',
      'date': '2023-06-20',
      'cause': 'Pneumonia',
      'icon': Icons.person_off
    },
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Death Records'),
      ),
      body: ListView.builder(
        itemCount: deaths.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              deaths[index]['icon'],
              color: Theme.of(context).primaryColor,
            ),
            title: Text(deaths[index]['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${deaths[index]['date']}'),
                Text('Cause: ${deaths[index]['cause']}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteRecord(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDeathDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDeathDialog() {
    _nameController.clear();
    _dateController.clear();
    _causeController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Death Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date of Death (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _causeController,
                decoration: const InputDecoration(
                  labelText: 'Cause of Death',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addDeathRecord,
              child: const Text('Add Record'),
            ),
          ],
        );
      },
    );
  }

  void _addDeathRecord() {
    if (_nameController.text.trim().isNotEmpty &&
        _dateController.text.trim().isNotEmpty &&
        _causeController.text.trim().isNotEmpty) {
      setState(() {
        deaths.add({
          'name': _nameController.text.trim(),
          'date': _dateController.text.trim(),
          'cause': _causeController.text.trim(),
          'icon': Icons.person_off,
        });
      });
      Navigator.pop(context);
    }
  }

  void _deleteRecord(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
              'Are you sure you want to delete ${deaths[index]['name']}\'s record?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  deaths.removeAt(index);
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
    _nameController.dispose();
    _dateController.dispose();
    _causeController.dispose();
    super.dispose();
  }
}