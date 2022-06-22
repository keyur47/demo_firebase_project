import 'package:flutter/material.dart';

class ScanQrCodeScreen extends StatelessWidget {
  static const routeName = '/ScanQrCodeScreen';
  const ScanQrCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('data'),
    ));
  }
}
