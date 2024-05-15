import 'package:flutter/material.dart';

class FakeStoreButton extends StatelessWidget {
  final Function() onPressed;
  final Widget? child;
  const FakeStoreButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        minimumSize: MaterialStateProperty.all(
          Size(MediaQuery.sizeOf(context).width * 0.75, 40),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: child,
      ),
    );
  }
}
