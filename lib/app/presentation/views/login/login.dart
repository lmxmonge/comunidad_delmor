import 'package:comunidad_delmor/app/presentation/views/login/local_widgets/boody_login.dart';
import 'package:comunidad_delmor/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  Login({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height + 15,
              child: Column(
                children: [
                  headerLogin(size: size),
                  const SizedBox(
                    height: 15,
                  ),
                  BoodyLogin(formKey: formKey),
                ],
              ),
            ),
          )),
    );
  }

  Widget headerLogin({Size? size}) {
    return Column(
      children: [
        SizedBox(
          height: size!.height * 0.33,
          width: 300,
          // child: rive.RiveAnimation.asset('lib/assets/animations/people.riv',useArtboardSize:true),
          child: Lottie.asset('lib/assets/animations/people3.json'),
        ),
        const Text(
          'BIENVENIDO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Comunidad DELMOR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
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
