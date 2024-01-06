import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/order_screen/components/order_place_detail.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;

  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(bold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  orderPlaceDetails("Order code", "Shipping Method",
                      data['order_code'], data['shipping_method']),
                  orderPlaceDetails(
                      "Order date",
                      "Payment Method",
                      intl.DateFormat()
                          .add_yMd()
                          .format((data['order-date'].toDate())),
                      data['payment_method']),
                  orderPlaceDetails("Payment Status", "Delivery Status",
                      "Unpaid", "Order Place"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address :"
                                .text
                                .fontFamily(bold)
                                .size(14)
                                .make(),

                            "${data['order_by_cuty']}"
                                .text
                                .fontFamily(bold)
                                .size(14)
                                .make(),
                            "${data['order_by_state']}"
                                .text
                                .fontFamily(bold)
                                .size(14)
                                .make(),
                            "${data['order_by_address']}"
                                .text
                                .fontFamily(bold)
                                .size(14)
                                .make(),
                            "${data['order_by_phone']}"
                                .text
                                .fontFamily(bold)
                                .size(14)
                                .make(),
                            // "${data['order_by_email']}".text.fontFamily(bold).size(14).make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Account"
                                  .text
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                              "${data['total_amount']}"
                                  .text
                                  .size(16)
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          data['orders'][index]['title'],
                          data['orders'][index]['tprice'],
                          "${data['orders'][index]['qty']} x",
                          "Total amount"),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ).box.outerShadowMd.white.make(),
              20.heightBox,
              // Row(
              //   children: [
              //     "SUB TOTAL"
              //         .text
              //         .size(18)
              //         .fontFamily(bold)
              //         .color(darkFontGrey)
              //         .make(),
              //
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
