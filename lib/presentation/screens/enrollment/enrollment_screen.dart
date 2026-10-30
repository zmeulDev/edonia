import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/providers/enrollment_provider.dart';

class EnrollmentScreen extends ConsumerWidget {
  const EnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(enrollmentProvider);
    final notifier = ref.read(enrollmentProvider.notifier);

    bool allGranted = permissions.every((p) => p.isGranted);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome to Edonia',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'To audit your privacy, Edonia needs a few system-level permissions. These are used locally and never leave your device.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: permissions.length,
                  itemBuilder: (context, index) {
                    final item = permissions[index];
                    return PermissionCard(
                      item: item,
                      onGrant: () async {
                        // Logic to open settings or request permission
                        bool granted = false;
                        if (item.id == 'storage') {
                          final status = await Permission.storage.request();
                          granted = status.isGranted;
                        } else {
                          // For Usage Access and Phone State, we'd typically 
                          // redirect to system settings via a custom method channel.
                          // For now, we simulate the grant for the UI flow.
                          granted = true; 
                        }
                        notifier.updatePermissionStatus(item.id, granted);
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: allGranted ? () {
                    // Navigate to Dashboard
                  } : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Enter Edonia', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PermissionCard extends StatelessWidget {
  final PermissionItem item;
  final VoidCallback onGrant;

  const PermissionCard({super.key, required this.item, required this.onGrant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: item.isGranted 
          ? Theme.of(context).colorScheme.primaryContainer 
          : Theme.of(context).colorScheme.surfaceVariant,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          item.label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: item.isGranted ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
        subtitle: Text(item.description),
        trailing: item.isGranted
            ? const Icon(Icons.check_circle, color: Colors.green)
            : ElevatedButton(
                onPressed: onGrant,
                style: ElevatedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text('Grant'),
              ),
      ),
    );
  }
}
