import 'package:flutter/material.dart';

class FakeStoreButton extends StatelessWidget {
  final Function() onPressed;
  const FakeStoreButton({super.key, required this.onPressed});

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
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Sign in',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
