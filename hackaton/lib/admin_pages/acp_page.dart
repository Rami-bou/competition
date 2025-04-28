import 'package:flutter/material.dart';

class AcpPage extends StatefulWidget {
  const AcpPage({super.key});

  @override
  State<AcpPage> createState() => _AcpPageState();
}

class _AcpPageState extends State<AcpPage> {
  final List<Map<String, dynamic>> acps = [
    {'name': 'ACP 1', 'icon': Icons.person_pin},
    {'name': 'ACP 2', 'icon': Icons.person_pin},
    {'name': 'ACP 3', 'icon': Icons.person_pin},
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACP List'),
      ),
      body: ListView.builder(
        itemCount: acps.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              acps[index]['icon'],
              color: Theme.of(context).primaryColor,
            ),
            title: Text(acps[index]['name']),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteAcp(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAcpDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddAcpDialog() {
    _nameController.clear();
    _passwordController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New ACP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'ACP Name',
                  hintText: 'Enter ACP name',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addAcp,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addAcp() {
    if (_nameController.text.trim().isNotEmpty) {
      setState(() {
        acps.add({
          'name': _nameController.text.trim(),
          'icon': Icons.person_pin,
        });
      });
      Navigator.pop(context);
    }
  }

  void _deleteAcp(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
              'Are you sure you want to delete ${acps[index]['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  acps.removeAt(index);
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
    _passwordController.dispose();
    super.dispose();
  }
}