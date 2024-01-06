import 'package:foodonlineapapp/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }
  var currentNavIndex = 0.obs;

  var username = '';

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get().then((value){
          if(value.docs.isEmpty){
            return value.docs.single['name'];
          }
    });
    // username = n;
    // print(username);
  }
}
