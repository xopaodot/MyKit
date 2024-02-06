import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bottom_navigate/image_contioner.dart';

class JenConnectUs extends StatelessWidget {
  const JenConnectUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer service'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              width: 100,
              height: 100,
              color: Colors.greenAccent,
              child: ImageBox(imageName: 'beifen.png',),
            ),
            const SizedBox(height: 22),
            const Text('Email: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const Text('xopaodot@gmail.com', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
