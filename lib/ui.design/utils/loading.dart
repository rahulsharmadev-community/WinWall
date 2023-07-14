import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool isScaffold;
  const LoadingWidget({super.key, this.isScaffold = false});

  @override
  Widget build(BuildContext context) {
    var child = const Center(child: CircularProgressIndicator());
    return isScaffold ? Scaffold(body: child) : child;
  }
}
