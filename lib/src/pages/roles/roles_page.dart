import 'package:flutter/material.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:comedor_utt/src/models/role.dart';
import 'package:comedor_utt/src/pages/roles/roles_controller.dart';
import 'package:flutter/scheduler.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController con = RolesController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Selecciona un rol')),
        body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
          child: ListView(
              children: con.user != null
                  ? con.user!.roles.map((rol) {
                      return cardRol(rol!);
                    }).toList()
                  : []),
        ));
  }

  Widget cardRol(Rol rol) {
    return GestureDetector(
      onTap: () {
        con.goToPage(rol.route);
      },
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: FadeInImage.assetNetwork(
              image: rol.image,
              fit: BoxFit.contain,
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: 'assets/img/no-image.png',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            rol.name,
            style: const TextStyle(fontSize: 16, color: MyColors.primaryColor),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
