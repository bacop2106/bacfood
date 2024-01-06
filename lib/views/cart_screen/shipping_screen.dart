import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/controllers/cart_controller.dart';
import 'package:foodonlineapapp/views/cart_screen/payment_screen.dart';
import 'package:foodonlineapapp/widget_common/custom_textfield.dart';
import 'package:foodonlineapapp/widget_common/our_button.dart';
import 'package:get/get.dart';

class ShippingDetail extends StatelessWidget {
  const ShippingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: 'Shipping Info'.text.fontFamily(bold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(redColor, whiteColor, "Continue", () {
            if (controller.addressController.text.length > 10) {
              Get.to(() => const PaymentMethods());
            }
            {
              VxToast.show(context, msg: "Please fill the form");
            }
          })),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                "Address", "Address", controller.addressController, false),
            customTextField("City", "City", controller.cityController, false),
            customTextField(
                "State", "State", controller.stateController, false),
            customTextField(
                "Phone", "Phone", controller.phoneController, false),
          ],
        ),
      ),
    );
  }
}
