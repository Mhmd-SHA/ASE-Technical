import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

class UserDetailsScreen extends ConsumerWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.user == null) {
      return const Scaffold(
        body: Center(child: Text('No user data available')),
      );
    }

    final user = authState.user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: () {
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('User Code: ${user.userCode}'),
            Text('Display Name: ${user.userDisplayName}'),
            Text('Email: ${user.email}'),
            Text('Employee Code: ${user.userEmployeeCode}'),
            Text('Company Code: ${user.companyCode}'),
            const Divider(height: 30),

            const Text(
              'User Locations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (user.userLocations.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user.userLocations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Location ${index + 1}: ${user.userLocations[index].locationCode}',
                    ),
                  );
                },
              )
            else
              const Text('No locations available'),
            const Divider(height: 30),

            const Text(
              'User Permissions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (user.userPermissions.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user.userPermissions.length,
                itemBuilder: (context, index) {
                  final permission = user.userPermissions[index];
                  return ListTile(
                    title: Text(permission.permissionName),
                    subtitle: Text('Status: ${permission.permissionStatus}'),
                  );
                },
              )
            else
              const Text('No permissions available'),
          ],
        ),
      ),
    );
  }
}
