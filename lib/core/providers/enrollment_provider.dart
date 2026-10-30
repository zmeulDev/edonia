import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

/// State representing the status of a required permission
class PermissionItem {
  final String id;
  final String label;
  final String description;
  final bool isGranted;

  PermissionItem({
    required this.id,
    required this.label,
    required this.description,
    this.isGranted = false,
  });

  PermissionItem copyWith({bool? isGranted}) {
    return PermissionItem(
      id: id,
      label: label,
      description: description,
      isGranted: isGranted ?? this.isGranted,
    );
  }
}

/// Provider that manages the status of all required permissions for Edonia
class EnrollmentNotifier extends Notifier<List<PermissionItem>> {
  @override
  List<PermissionItem> build() {
    return [
      PermissionItem(
        id: 'usage_access',
        label: 'Usage Access',
        description: 'Allows Edonia to see which apps are running in the background.',
      ),
      PermissionItem(
        id: 'phone_state',
        label: 'Phone State',
        description: 'Necessary to map network data to specific app IDs.',
      ),
      PermissionItem(
        id: 'storage',
        label: 'Storage Access',
        description: 'Needed to save your privacy audits locally on the device.',
      ),
    ];
  }

  Future<void> updatePermissionStatus(String id, bool granted) async {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isGranted: granted) else item,
    ];
  }
}

final enrollmentProvider = NotifierProvider<EnrollmentNotifier, List<PermissionItem>>(() {
  return EnrollmentNotifier();
});
