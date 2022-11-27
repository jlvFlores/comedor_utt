import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';

class ClientProductsDetailPage extends StatefulWidget {
  
  final Product product;
  
  const ClientProductsDetailPage({Key key, @required this.product}) : super(key: key);
  
  @override
  State<ClientProductsDetailPage> createState() => _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {
  
  ClientProductsDetailController con = ClientProductsDetailController();
  

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      con.init(context, refresh, widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          imageSlideshow(),
          textName(),
          textDescription(),
          const Spacer(),
          addOrRemoveItem(),
          buttonShoppingBag()
        ],
      ),
    );
  }

  Widget imageSlideshow() {
    return SafeArea(
      child: Stack(
        children: [
          ImageSlideshow(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            initialPage: 0,
            indicatorColor: Colors.transparent, // If adding more than one image change transparent to a visible color 
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              print('Page changed: $value');
            },
            // autoPlayInterval: 20000, // For more than one image
            children: [
              FadeInImage(
                image: con.product?.image1 != null
                ? NetworkImage(con.product.image1)
                : const AssetImage('assets/img/no-image.png'),
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 50),
                placeholder: const AssetImage('assets/img/no-image.png'),
              ),
            ],
          ),
          Positioned(
            left: 5,
            top: 10,
            child: IconButton(
              onPressed: con.close,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: MyColors.primaryColor,
                size: 35,
              ),
            )
          )
        ],
      ),
    );
  }

  Widget textName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30, left: 30, top: 30),
      child: Text(
        con.product?.name ?? '',
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30, left: 30, top: 15),
      child: Text(
        con.product?.description ?? '',
        style: const TextStyle(
            fontSize: 15,
            color: Colors.grey
        ),
      ),
    );
  }

  Widget addOrRemoveItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: [
          IconButton(
              onPressed: con.removeItem,
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.grey,
                size: 30,
              )
          ),
          Text(
            '${con.counter}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          ),
          IconButton(
              onPressed: con.addItem,
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.grey,
                size: 30,
              )
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Text(
              '${con.productPrice ?? 0}\$',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonShoppingBag() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: con.addToBag,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'AGREGAR A LA BOLSA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 30, top: 6),
                height: 30,
                child: Image.asset('assets/img/bag.png'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {

    });
  }
}
