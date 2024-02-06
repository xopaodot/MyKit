
import 'package:flutter/material.dart';

import '../../bottom_navigate/image_contioner.dart';

class JenAboutMePage extends StatelessWidget {
  const JenAboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
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
            const SizedBox(height: 10),
            const Text('perseverance prevails', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
