import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Demo
    extends ConsumerStatefulWidget {
  const Demo({super.key});

  @override
  ConsumerState<Demo> createState() =>
      _DemoState();
}

class _DemoState
    extends ConsumerState<Demo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
