import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/models/category.dart';
import 'package:comedor_utt/src/utils/my_colors.dart';
import 'package:comedor_utt/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:comedor_utt/src/widgets/no_data_widget.dart';

class ClientProductsListPage extends StatefulWidget {
    const ClientProductsListPage({Key key}) : super(key: key);

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  
  ClientProductsListController con = ClientProductsListController();

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
      length: con.categories.length,
      child: Scaffold(
        key: con.key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(170),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: [
              shoppingBag()
            ],
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 40),
                menuDrawerIcon(),
                const SizedBox(height: 20),
                textFieldSearch()
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(con.categories.length, (index) {
                return Tab(
                  child: Text(con.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        drawer: drawer(),
        body: TabBarView(
          children: con.categories.map((Category category) {
            return FutureBuilder(
                future: con.getProducts(category.id, con.productName),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {

                  if (snapshot.hasData) {

                    if (snapshot.data.isNotEmpty) {
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7
                        ),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index) {
                          return cardProduct(snapshot.data[index]);
                        }
                      );
                    }
                    else {
                      return const NoDataWidget(text: 'No hay productos');
                    }
                  }
                  else {
                    return const NoDataWidget(text: 'No hay productos');
                  }
                }
            );
          }).toList(),
        )
      ),
    );
  }

  Widget cardProduct(Product product) {
    return GestureDetector(
      onTap: () {
        con.openBottomSheet(product);
      },
      child: SizedBox(
        height: 150,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: const EdgeInsets.all(10),
                    child: FadeInImage(
                      image: product?.image1 != null
                      ? NetworkImage(product.image1)
                      : const AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: const Duration(milliseconds: 50),
                      placeholder: const AssetImage('assets/img/no-image.png')
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 35,
                    child: Text(
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'NimbusSans'
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      '${product.price ?? 0}\$',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NimbusSans'
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: -1.0,
                right: -1.0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(20),
                    )
                  ),
                  child: const Icon(Icons.add, color: Colors.white,),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget shoppingBag() {
    return GestureDetector(
      onTap: con.goToOrderCreatePage,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 13),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
            right: 16,
            top: 15,
            child: Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30)
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: con.onChangeText,
        decoration: InputDecoration(
          hintText: 'Buscar',
          suffixIcon: Icon(
            Icons.search,
            color: Colors.grey[400]
          ),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey[500]
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey[300]
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey[300]
            )
          ),
          contentPadding: const EdgeInsets.all(15)
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
                    fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                Text(
                  '${con.user?.email ?? ''} ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                Text(
                  '${con.user?.userCode ?? ''} ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                )
              ],
            )
          ),
          ListTile(
            onTap: con.goToUpdatePage,
            title: const Text('Editar perfil'),
            trailing: const Icon(Icons.edit_outlined),
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
