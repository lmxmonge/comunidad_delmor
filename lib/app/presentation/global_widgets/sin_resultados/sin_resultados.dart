import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SinResultados extends StatelessWidget {
  final String cuerpo;

  const SinResultados({super.key, required this.cuerpo});

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height - (kToolbarHeight * 2) ,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: size.height * 0.16,
              child: Image.asset('lib/assets/images/sin_resultados.png')),
        const  SizedBox(
            height: 10,
          ),
          Positioned(
            top: size.height * 0.48,
            child: Container(
              width: size.width * 0.95 ,
              child: Wrap(
                // verticalDirection: VerticalDirection.up,
                // direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                // crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    cuerpo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  )
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}
