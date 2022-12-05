import 'package:comedor_utt/src/models/order.dart';
import 'package:comedor_utt/src/utils/relative_time_util.dart';
import 'package:comedor_utt/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:comedor_utt/src/pages/diner/orders/list/diner_orders_list_controller.dart';

class DinerOrdersListPage extends StatefulWidget {
  const DinerOrdersListPage({Key key}) : super(key: key);

  @override
  State<DinerOrdersListPage> createState() => _DinerOrdersListPageState();
}

class _DinerOrdersListPageState extends State<DinerOrdersListPage> {

  DinerOrdersListController con = DinerOrdersListController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: con.status.length,
      child: Scaffold(
        key: con.key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 40),
                menuDrawerIcon(),
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(con.status.length, (index) {
                return Tab(
                  child: Text(con.status[index] ?? ''),
                );
              }),
            ),
          ),
        ),
        drawer: drawer(),
        body: TabBarView(
          children: con.status.map((String status) {
            return FutureBuilder(
                future: con.getOrders(status),
                builder: (context, AsyncSnapshot<List<Order>> snapshot) {

                  if (snapshot.hasData) {

                    if (snapshot.data.isNotEmpty) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index) {
                          return cardOrder(snapshot.data[index]);
                        }
                      );
                    }
                    else {
                      return const NoDataWidget(text: 'No hay pedidos');
                    }
                  }
                  else {
                    return const NoDataWidget(text: 'No hay pedidos');
                  }
                }
            );
          }).toList(),
        )
      ),
    );
  }

  Widget cardOrder(Order order) {
    return GestureDetector(
      onTap: () {
        con.openBottomSheet(order);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 140,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)
                    )
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Orden #${order.id}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'Roboto'
                      ),
                    ),
                  )
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: Text(
                          'Pedido: ${RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0)}',
                          style: const TextStyle(
                              fontSize: 13
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Cliente: ${order.client?.name ?? ''}',
                          style: const TextStyle(
                              fontSize: 13
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Matricula/No. Empleado: ${order.client?.userCode ?? ''}',
                          style: const TextStyle(
                              fontSize: 13
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ]
          ),
        ),
      ),
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
          ListTile(
            onTap: con.goToCategoryCreate,
            title: const Text('Crear categoria'),
            trailing: const Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: con.goToProductCreate,
            title: const Text('Crear producto'),
            trailing: const Icon(Icons.local_pizza),
          ),
          con.user != null ? 
          con.user.roles.length > 1 ?
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
