import 'package:flutter/material.dart';

class DspPage extends StatefulWidget {
  const DspPage({super.key});

  @override
  State<DspPage> createState() => _DspPageState();
}

class _DspPageState extends State<DspPage> {
  final List<Map<String, dynamic>> dsps = [
    {'name': 'DSP 1', 'icon': Icons.security},
    {'name': 'DSP 2', 'icon': Icons.security},
    {'name': 'DSP 3', 'icon': Icons.security},
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DSP List'),
      ),
      body: ListView.builder(
        itemCount: dsps.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              dsps[index]['icon'],
              color: Theme.of(context).primaryColor,
            ),
            title: Text(dsps[index]['name']),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteDsp(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDspDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDspDialog() {
    _nameController.clear();
    _passwordController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New DSP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'DSP Name',
                  hintText: 'Enter DSP name',
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
              onPressed: _addDsp,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addDsp() {
    if (_nameController.text.trim().isNotEmpty) {
      setState(() {
        dsps.add({
          'name': _nameController.text.trim(),
          'icon': Icons.security,
        });
      });
      Navigator.pop(context);
    }
  }

  void _deleteDsp(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
              'Are you sure you want to delete ${dsps[index]['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  dsps.removeAt(index);
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