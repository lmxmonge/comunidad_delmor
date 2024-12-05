import 'package:comunidad_delmor/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_controller.dart';

class BoodyLogin extends StatefulWidget {
  const BoodyLogin({super.key});

  @override
  State<BoodyLogin> createState() => _BoodyLoginState();
}

class _BoodyLoginState extends State<BoodyLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final LoginController loginController = Get.find<LoginController>();

  String? _usernameError;
  String? _passwordError;

  void _validateAndSubmit() {
    setState(() {
      _usernameError = _usernameController.text.isEmpty
          ? "El campo no puede estar vacío"
          : _usernameController.text.length < 3
          ? "Debe tener al menos 3 caracteres"
          : null;

      _passwordError = _passwordController.text.isEmpty
          ? "El campo no puede estar vacío"
          : _passwordController.text.length < 3
          ? "Debe tener al menos 3 caracteres"
          : null;
    });

    if (_usernameError == null && _passwordError == null) {
      loginController.login(
        _usernameController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Iniciar Sesión",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              _customTextFormField(
                labelText: "Nombre",
                hintText: "Nombre de Usuario",
                controller: _usernameController,
                errorText: _usernameError,
              ),
              _customTextFormField(
                labelText: "Contraseña",
                hintText: "Digite la contraseña",
                password: true,
                controller: _passwordController,
                errorText: _passwordError,
              ),
              SizedBox.fromSize(size: const Size(0, 10)),
              Obx(() {
                if (loginController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colores.secondary,
                  ),
                  onPressed: _validateAndSubmit,
                  child: const Text(
                    "Iniciar Sesión",
                    style: TextStyle(color: Colores.white),
                  ),
                );
              }),
              SizedBox.fromSize(size: const Size(0, 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextFormField({
    required String labelText,
    required String hintText,
    TextEditingController? controller,
    String? errorText,
    bool? password,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: password == true ? _obscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: password == true
              ? IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
          )
              : null,
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
          errorText: errorText, // Aquí se muestra el error
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
