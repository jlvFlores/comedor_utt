import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/pages/client/products/list/client_products_list_controller.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({super.key});

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductsListController con = ClientProductsListController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: con.logout, 
          child: const Text('Cerrar session'),
        )
      ),
    );
  }
}
