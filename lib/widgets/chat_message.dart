import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  ChatMessage({
    @required this.texto,
    @required this.uid,
    @required this.animationController
  });

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.elasticOut,),
        child: Container(
          child: this.uid == authService.usuario.uid
            ? _myMessage()
            : _notMyMessage()
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all( 8.0 ),
        margin: EdgeInsets.only(
          bottom: 5,
          right: 5,
          left: 50
        ),
        child: Text( this.texto, style: TextStyle( color: Colors.white ) ),
        decoration: BoxDecoration(
          color: Color(0xffFD9EFF),
          borderRadius: BorderRadius.circular( 10 )
        )
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all( 8.0 ),
        margin: EdgeInsets.only(
          bottom: 5,
          right: 50,
          left: 5
        ),
        child: Text( this.texto, style: TextStyle( color: Colors.black87 ) ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular( 10 )
        )
      ),
    );
  }


}