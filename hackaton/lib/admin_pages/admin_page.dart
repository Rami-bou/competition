// admin_page.dart
import 'package:flutter/material.dart';
import 'package:hackaton/admin_pages/acp_page.dart';
import 'package:hackaton/admin_pages/dsp_page.dart';
import 'package:hackaton/admin_pages/hospital_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
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
                  _buildAdminButton(
                    context: context,
                    onTap: () => _navigateToHospitals(context),
                    label: "Hospitals",
                  ),
                  _buildAdminButton(
                    context: context,
                    onTap: () => _navigateToDSP(context), // Add your DSP navigation here
                    label: "DSP",
                  ),
                  _buildAdminButton(
                    context: context,
                    onTap: () => _navigateToACP(context), // Add your ACP navigation here
                    label: "ACP's",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHospitals(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HospitalsPage()),
    );
  }
  void _navigateToDSP(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DspPage()),
    );
  }
  void _navigateToACP(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AcpPage()),
    );
  }

  Widget _buildAdminButton({
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
}