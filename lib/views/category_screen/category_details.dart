import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/controllers/product_controller.dart';
import 'package:foodonlineapapp/services/firestore_services.dart';
import 'package:foodonlineapapp/views/category_screen/item_details.dart';
import 'package:foodonlineapapp/widget_common/bg_widget.dart';
import 'package:foodonlineapapp/widget_common/loading_indicator.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;

  const CategoryDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: title!.text.fontFamily(bold).black.make(),
            ),
            body: StreamBuilder(
              stream: FirestorServices.getProducts(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: "No products found!".text.color(darkFontGrey).make(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(
                                controller.subcat.length,
                                (index) => "${controller.subcat[index]}"
                                    .text
                                    .size(14)
                                    .fontFamily(bold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .white
                                    .rounded
                                    .size(120, 50)
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()),
                          ),
                        ),
                        20.heightBox,
                        Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisExtent: 250),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      const Spacer(),
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(bold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${data[index]['p_price']}"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .roundedSM
                                      .outerShadowSm
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    controller.checkIfFav(data[index]);
                                    Get.to(() => ItemDetails(
                                          title: "${data[index]['p_name']}",
                                          data: data[index],
                                        ));
                                  });
                                }))
                      ],
                    ),
                  );
                }
              },
            )));
  }
}
