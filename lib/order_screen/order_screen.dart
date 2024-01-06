import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/order_screen/orders_details.dart';
import 'package:foodonlineapapp/services/firestore_services.dart';
import 'package:foodonlineapapp/widget_common/loading_indicator.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "My order".text.color(darkFontGrey).fontFamily(bold).make(),
      ),
      body: StreamBuilder(
        stream: FirestorServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No order yet!".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: "${index + 1}"
                        .text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .xl
                        .make(),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .fontFamily(bold)
                        .make(),
                    trailing: IconButton(
                      onPressed: () {
                        Get.to(() => OrderDetails(
                              data: data[index],
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: darkFontGrey,
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
