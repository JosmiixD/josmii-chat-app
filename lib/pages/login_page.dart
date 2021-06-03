import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_label.dart';
import 'package:chat/widgets/custom_logo.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomLogo(
                  imageUrl: 'assets/logo.png',
                  text: 'Login',
                ),

                _Form(),

                CustomLabel(
                  route: 'register',
                  primaryText: '¿No tienes cuenta?',
                  secondaryText: 'Crea una ahora!',
                ),

                _Terminos(),
                
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Terminos extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only( bottom: 20 ),
      child: Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w300))
    );
  }
}


class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final authService   = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only( top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: <Widget>[

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passwordCtrl,
            isPassword: true,
          ),

          BotonAzul(
            text: 'Ingresar',
            onPressed: authService.autenticando ? null : () async {
              
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(this.emailCtrl.text.trim(), this.passwordCtrl.text.trim());

              if( loginOk ) {
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');

              } else {
                //Mostrar alerta
                mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
              }

            },
          ),
          
        ]
      ),
    );
  }
}

