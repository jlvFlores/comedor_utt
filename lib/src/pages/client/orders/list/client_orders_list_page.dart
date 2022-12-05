import 'package:comedor_utt/src/utils/relative_time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/models/order.dart';
import 'package:comedor_utt/src/pages/client/orders/list/client_orders_list_controller.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:comedor_utt/src/widgets/no_data_widget.dart';

class ClientOrdersListPage extends StatefulWidget {
  
  const ClientOrdersListPage({Key key}) : super(key: key);

  @override
  State<ClientOrdersListPage> createState() => _ClientOrdersListPageState();
}

class _ClientOrdersListPageState extends State<ClientOrdersListPage> {

  ClientOrdersListController con = ClientOrdersListController();

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
      length: con.status?.length,
      child: Scaffold(
        key: con.key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            title: const Text('Mis pedidos'),
            backgroundColor: MyColors.primaryColor,
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.white,
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
                            return _cardOrder(snapshot.data[index]);
                          }
                      );
                    }
                    else {
                      return const NoDataWidget(text: 'No hay ordenes');
                    }
                  }
                  else {
                    return const NoDataWidget(text: 'No hay ordenes');
                  }
                }
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _cardOrder(Order order) {
    return GestureDetector(
      onTap: () {
        con.openBottomSheet(order);
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                        topRight: Radius.circular(15),
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
                          fontFamily: 'NimbusSans'
                      ),
                    ),
                  ),
                )
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void refresh() {
    setState(() {}); // CTRL + S
  }

}
