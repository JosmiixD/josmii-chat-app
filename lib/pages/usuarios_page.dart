import 'package:flutter/material.dart';
import 'package:chat/models/usuario.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        uid: '1', nombre: 'Monica', email: 'monica@josmii.com', online: true, avatarUrl: 'assets/svg/002-girl.svg'),
    Usuario(
        uid: '2', nombre: 'Gladis', email: 'gladis@josmii.com', online: false, avatarUrl: 'assets/svg/003-girl-1.svg'),
    Usuario(
        uid: '3', nombre: 'Naty', email: 'naty@josmii.com', online: true, avatarUrl: 'assets/svg/005-girl-2.svg'),
    Usuario(
        uid: '4', nombre: 'Papá', email: 'salvador@josmii.com', online: true, avatarUrl: 'assets/svg/009-boy-4.svg'),
    Usuario(
        uid: '4', nombre: 'Papá', email: 'salvador@josmii.com', online: true, avatarUrl: 'assets/svg/009-boy-4.svg'),
    Usuario(
        uid: '4', nombre: 'Papá', email: 'salvador@josmii.com', online: true, avatarUrl: 'assets/svg/009-boy-4.svg'),
    Usuario(
        uid: '4', nombre: 'Papá', email: 'salvador@josmii.com', online: true, avatarUrl: 'assets/svg/009-boy-4.svg'),
    Usuario(
        uid: '4', nombre: 'Papá', email: 'salvador@josmii.com', online: true, avatarUrl: 'assets/svg/009-boy-4.svg'),
    Usuario(
        uid: '4', nombre: 'Papá', email: 'salvador@josmii.com', online: true, avatarUrl: 'assets/svg/009-boy-4.svg'),
    Usuario(
        uid: '4', nombre: 'Papá', email: 'salvador@josmii.com', online: true, avatarUrl: 'assets/svg/009-boy-4.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Good morning',
                  style: TextStyle(color: Colors.black54, fontSize: 15.0)),
              Text('Josmar Salvador',
                  style: TextStyle(color: Colors.black87, fontSize: 17.0)),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.all(10),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: Text('JS',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600))),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.check_circle, color: Colors.blue.shade200),
            ),
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: Colors.blue[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _listViewUsers(size), 
              _listChats(size)
            ],
          ),
        ));
  }

  Stack _listChats(Size size) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only( topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            height: size.height * 0.70),
        Container(
          padding: EdgeInsets.only(top: 15),
          height: size.height * 0.70,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text('Chats'),
              Expanded(
                child: _listViewUsuarios(),
              )
            ]
          ),
        ),
      ],
    );
  }

  Widget _listViewUsers(Size size) {
    return Container(
      // margin: EdgeInsets.symmetric( horizontal: 10),
      height: size.height * 0.15,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: usuarios.length,
        itemBuilder: (context, i) {
          return Container(
            width: size.width * 0.3,
            child: Container(
              margin: EdgeInsets.all( 5 ),
              decoration: BoxDecoration( borderRadius: BorderRadius.circular(10), color: Colors.white,), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: usuarios[i].online ? Colors.blue.shade200 : Colors.grey.shade400,
                    child: SvgPicture.asset(usuarios[i].avatarUrl)
                  ),
                  Text( usuarios[i].nombre, overflow: TextOverflow.ellipsis, style: TextStyle( fontWeight: FontWeight.w500, ),)

                ],
              )
            ),
          );
        },
      ),
    );
  }


  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(color: Colors.transparent),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: Container(
        width: 40,
        height: 40,
        child: Center(
            child: Text(
          usuario.nombre.substring(0, 2),
          style: TextStyle(color: Colors.white),
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade200),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.grey,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
}
