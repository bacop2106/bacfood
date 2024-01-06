import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/controllers/cart_controller.dart';
import 'package:foodonlineapapp/services/firestore_services.dart';
import 'package:foodonlineapapp/views/cart_screen/shipping_screen.dart';
import 'package:foodonlineapapp/widget_common/loading_indicator.dart';
import 'package:foodonlineapapp/widget_common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put((CartController()));
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              redColor, whiteColor, "Procced to shipping", () {
                Get.to(()=>const ShippingDetail());
          }),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              "Shopping cart".text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body: StreamBuilder(
          stream: FirestorServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.caculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  leading: Image.network("${data[index]['img']}",width: 80,fit: BoxFit.cover,),
                                  title: "${data[index]['title']}   (X${data[index]['qty']})"
                                      .text
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                  subtitle: "${data[index]['tprice']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FirestorServices.deleteDocument(
                                        data[index].id);
                                  }));
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total price"
                            .text
                            .fontFamily(bold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(bold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(lightGolden)
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .make(),
                    // SizedBox(
                    //   width: context.screenWidth - 60,
                    //   child: ourButton(
                    //       redColor, whiteColor, "Procced to shipping", () {}),
                    // )
                  ],
                ),
              );
            }
          },
        ));
  }


}
