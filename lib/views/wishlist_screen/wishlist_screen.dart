import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/services/firestore_services.dart';
import 'package:foodonlineapapp/widget_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: "My Wishlist".text.color(darkFontGrey).fontFamily(bold).make(),
      ),
      body: StreamBuilder(
        stream: FirestorServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "No order yet!".text.color(darkFontGrey).make(),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
