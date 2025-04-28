import 'package:flutter/material.dart';
import 'package:hackaton/hospital_dashbored/add_birth.dart';
import 'package:hackaton/hospital_dashbored/add_death.dart';
class hospital_home extends StatefulWidget {
  const hospital_home({super.key});

  @override
  State<hospital_home> createState() => _hospital_homeState();
}

class _hospital_homeState extends State<hospital_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  _Button(
                    context: context,
                    onTap: () => _navigateToaddbirth(context),
                    label: "Hospitals",
                  ),
                  _Button(
                    context: context,
                    onTap: () => _navigateToadddeath(context), // Add your DSP navigation here
                    label: "DSP",
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
void _navigateToaddbirth(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const add_birth()),
  );
}
void _navigateToadddeath(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DeathRecordsPage()),
  );
}
Widget _Button({
  required BuildContext context,
  required VoidCallback onTap,
  required String label,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 100,
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Theme.of(context).colorScheme.tertiary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
