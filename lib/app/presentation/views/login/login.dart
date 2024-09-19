import 'package:comunidad_delmor/app/presentation/views/login/local_widgets/boody_login.dart';
import 'package:comunidad_delmor/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart' as rive;

class Login extends StatelessWidget {
  Login({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      body: Container(
        //gradiente
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colores.backgroundLogin,
                Colores.backgroundLogin2,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  headerLogin(),
                  const SizedBox(height: 15,),
                  BoodyLogin(formKey: formKey),
                ],
              ),
            ),
          )),
    );
  }

  Widget headerLogin() {
    return Column(
      children: [
        SizedBox(
            height: 230,
            width: 300,
            child: rive.RiveAnimation.asset('lib/assets/animations/people.riv',useArtboardSize:true),
            // child: Lottie.asset('lib/assets/animations/people2.json'),
        ),

        Text(
          'BIENBENIDO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Comunidad DELMOR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "v2.0.0",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
