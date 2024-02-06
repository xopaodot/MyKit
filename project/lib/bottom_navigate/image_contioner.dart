import 'package:flutter/cupertino.dart';

class ImageBox extends StatelessWidget {
  ImageBox({Key? key, required this.imageName, this.h, this.w}) : super(key: key);

  final String imageName;
  double? h ;
  double? w ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h ?? 20,
      width:  w ?? 20,
      child: Image.asset('images/$imageName', fit: BoxFit.fill),
    );
  }
}

