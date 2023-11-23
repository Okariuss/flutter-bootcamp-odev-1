import 'package:flutter/material.dart';

class BaseSnapshotControl<T> extends StatelessWidget {
  const BaseSnapshotControl({
    required this.snapshot,
    required this.widget,
  });

  final AsyncSnapshot<T> snapshot;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (snapshot.data == null || _isEmpty(snapshot.data)) {
      return const Text('No data available');
    } else {
      return widget;
    }
  }

  bool _isEmpty(data) {
    if (data is List) {
      return data.isEmpty;
    }
    // You might need to add more conditions based on the types you're handling
    return false;
  }
}
