import 'package:flutter/material.dart';
class add_birth extends StatefulWidget {
  const add_birth({super.key});

  @override
  State<add_birth> createState() => _add_birthState();
}

class _add_birthState extends State<add_birth> {
  final List<Map<String, dynamic>> hospitals = [
    {'name': 'Hospital 1', 'icon': Icons.local_hospital},
    {'name': 'Hospital 2', 'icon': Icons.local_hospital},
    {'name': 'Hospital 3', 'icon': Icons.local_hospital},
  ];
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
