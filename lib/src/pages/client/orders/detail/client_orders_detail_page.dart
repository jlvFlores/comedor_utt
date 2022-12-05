import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/models/order.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/pages/client/orders/detail/client_orders_detail_controller.dart';
import 'package:comedor_utt/src/utils/relative_time_util.dart';
import 'package:comedor_utt/src/widgets/no_data_widget.dart';

class ClientOrdersDetailPage extends StatefulWidget {

  final Order order;

  const ClientOrdersDetailPage({Key key, @required this.order}) : super(key: key);

  @override
  State<ClientOrdersDetailPage> createState() => _ClientOrdersDetailPageState();
}

class _ClientOrdersDetailPageState extends State<ClientOrdersDetailPage> {

  ClientOrdersDetailController con = ClientOrdersDetailController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      con.init(context, refresh, widget.order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden #${con.order?.id ?? ''}'),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 18, right: 15),
            child: Text(
              'Total: ${con.total}\$',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                color: Colors.grey[400],
                endIndent: 30, // DERECHA
                indent: 30, //IZQUIERDA
              ),
              const SizedBox(height: 10),
              textData('Estado:', con.order?.status ?? ''),
              textData(
                  'Fecha de pedido:', 
                  RelativeTimeUtil.getRelativeTime(con.order?.timestamp ?? 0)
              ),
            ],
          ),
        ),
      ),
      body: con.order?.products?.length != null
      ? ListView(
        children: con.order.products.map((Product product) {
          return cardProduct(product);
        }).toList(),
      )
      : const NoDataWidget(text: 'Ningun producto agregado',),
    );
  }

  Widget textData(String title, String content) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          content,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget cardProduct(Product product) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            imageProduct(product),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Cantidad: ${product.quantity}',
                  style: const TextStyle(
                      fontSize: 13
                  ),
                ),
              ],
            ),

          ],
        ),
    );
  }
  

  Widget imageProduct(Product product) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[200]
      ),
      child: FadeInImage(
        image: product.image1 != null
            ? NetworkImage(product.image1)
            : const AssetImage('assets/img/no-image.png'),
        fit: BoxFit.contain,
        fadeInDuration: const Duration(milliseconds: 50),
        placeholder: const AssetImage('assets/img/no-image.png'),
      ),
    );
  }

  
  void refresh() {
    setState(() {});
  }
}
