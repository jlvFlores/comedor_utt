import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:comedor_utt/src/pages/admin/orders/list/admin_orders_list_controller.dart';

class AdminOrdersListPage extends StatefulWidget {
  const AdminOrdersListPage({super.key});

  @override
  State<AdminOrdersListPage> createState() => _AdminOrdersListPageState();
}

class _AdminOrdersListPageState extends State<AdminOrdersListPage> {
  AdminOrdersListController con = AdminOrdersListController();

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
      key: con.key,
      appBar: AppBar(
        leading: menuDrawerIcon(),
      ),
      drawer: drawer(),
      body: const Center(
        child: Text(
          'Admin Page'
        )
      )
    );
  }

  Widget menuDrawerIcon() {
    return GestureDetector(
      onTap: con.openDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: MyColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${con.user?.name ?? ''} ',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                Text(
                  '${con.user?.email ?? ''} ',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                Text(
                  '${con.user?.userCode ?? ''} ',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  maxLines: 1,
                )
              ],
            )),
          con.user != null ? 
          con.user!.roles.length > 1 ?
          ListTile(
            onTap: con.goToRoles,
            title: const Text('Seleccionar rol'),
            trailing: const Icon(Icons.person_outlined),
          ) : Container() : Container(),
          ListTile(
            onTap: con.logout,
            title: const Text('Cerrar sesion'),
            trailing: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
