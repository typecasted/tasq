import 'package:flutter/material.dart';

class FullScreenLoader extends StatefulWidget {
  const FullScreenLoader({super.key});

  @override
  State<FullScreenLoader> createState() => _FullScreenLoaderState();
}

class _FullScreenLoaderState extends State<FullScreenLoader> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

void showFullScreenLoader({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const FullScreenLoader(),
  );
}

void hideFullScreenLoader({required BuildContext context}) {
  Navigator.pop(context);
}
