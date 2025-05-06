import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';

class LoginView extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, vm, _) {
        if (vm.session == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Login')),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(controller: controller),
                  ElevatedButton(
                    onPressed: () => vm.login(controller.text),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('Dashboard')),
            body: Column(
              children: [
                Text('Hello, ${vm.session!.username}'),
                Text('Session ID: ${vm.session!.sessionId}'),
                if (vm.message != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('🔔 ${vm.message!}'),
                  ),
                ElevatedButton(
                  onPressed: () => vm.logout(),
                  child: const Text('Logout'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
