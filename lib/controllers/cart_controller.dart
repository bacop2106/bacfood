import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  var addressController = TextEditingController();
  var stateController = TextEditingController();
  var phoneController = TextEditingController();
  var cityController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];

  var placingOrder = false.obs;

  caculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {

    placingOrder(true);

    await getProductDetails();
    await firestore.collection(orderCollection).doc().set({
      'order_code': "233981237",
      'order-date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_cuty': cityController.text,
      'order_by_phone': phoneController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivery': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
        'tprice': productSnapshot[i]['tprice'],
        'vendor_id':productSnapshot[i]['vendor_id'],
      });
    }
  }

  clearCart(){
    for(var i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
