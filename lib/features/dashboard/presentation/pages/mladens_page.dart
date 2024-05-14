import 'package:flutter/material.dart';

class MladensPage extends StatelessWidget {
  static const routeName = '/mladen';
  const MladensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        title: const Text('Mladens page'),
        backgroundColor: const Color(0xfff5f5f5),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: 200,
                  height: 200,
                  color: Colors.green,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: 200,
                  height: 200,
                  color: Colors.red,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: 200,
                  height: 200,
                  color: Colors.green,
                  child: const Text(
                    'Green square',
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: 200,
                  height: 200,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
