

import 'package:architecture_demo/provider/provider.dart';
import 'package:architecture_demo/widgets/loader_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnotherScreen extends ConsumerWidget {
  const AnotherScreen({Key? key}) : super(key: key);

  Future<void> performAsyncOperation(BuildContext context, WidgetRef ref) async {
    ref.read(loadingProvider.notifier).startLoading();

    // Simulate a network request or any async operation
    await Future.delayed(const Duration(seconds: 2));

    ref.read(loadingProvider.notifier).stopLoading();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
// final selectedUser = ref.watch/(selectedUserProvider).state;
// final selectedUser = ref.watch(selectedUserProvider)?.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Operation with Loader'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => performAsyncOperation(context, ref),
              child: const Text('Start Async Operation'),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: LoadingDialog(),
              ),
            ),
        ],
      ),
    );
  }
}

