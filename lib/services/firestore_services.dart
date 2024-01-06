import 'package:foodonlineapapp/consts/consts.dart';

class FirestorServices {
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(orderCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
        } else {}
      })
    ]);
    return res;
  }

  static allproducts() {
    return firestore.collection(productsCollection).snapshots();
  }
}
