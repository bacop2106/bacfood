import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/consts/lits.dart';
import 'package:foodonlineapapp/controllers/cart_controller.dart';
import 'package:foodonlineapapp/views/home_screen/home.dart';
import 'package:foodonlineapapp/widget_common/loading_indicator.dart';
import 'package:get/get.dart';

import '../../widget_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: 'Choose Payment Methods'.text.color(darkFontGrey).make(),
        ),
        bottomNavigationBar: SizedBox(
            height: 60,
            child: controller.placingOrder.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : ourButton(redColor, whiteColor, "Place my order", () async{
                    controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(const Home());
                  })),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                          style: BorderStyle.solid,
                        )),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        width: double.infinity,
                        height: 100,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                value: true,
                                onChanged: (value) {},
                              ),
                            )
                          : Container(),
                      Positioned(
                          right: 10,
                          bottom: 0,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(bold)
                              .size(16)
                              .make())
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
