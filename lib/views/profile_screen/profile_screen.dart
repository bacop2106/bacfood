import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/consts/lits.dart';
import 'package:foodonlineapapp/controllers/auth_controller.dart';
import 'package:foodonlineapapp/controllers/profile_controller.dart';
import 'package:foodonlineapapp/order_screen/order_screen.dart';
import 'package:foodonlineapapp/services/firestore_services.dart';
import 'package:foodonlineapapp/views/auth_screen/login_screen.dart';
import 'package:foodonlineapapp/views/profile_screen/components/details_cart.dart';
import 'package:foodonlineapapp/views/profile_screen/components/edit_profile_screen.dart';
import 'package:foodonlineapapp/views/wishlist_screen/wishlist_screen.dart';
import 'package:foodonlineapapp/widget_common/bg_widget.dart';
import 'package:foodonlineapapp/widget_common/loading_indicator.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    FirestorServices.getCounts;
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestorServices.getUser(currentUser!.uid),
                // initialData: ,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.edit,
                                  color: whiteColor,
                                )).onTap(() {
                              controller.nameController.text = data['name'];
                              // controller.passController.text =
                              //     data['password'];
                              Get.to(() =>
                                  EditProflieScreen(
                                    data: data,
                                  ));
                            }),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 0.8),
                            child: Row(
                              children: [
                                data['imageUrl'] == ''
                                    ? Image
                                    .asset(
                                  imgProfile2,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make()
                                    : Image
                                    .network(
                                  data['imageUrl'],
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make(),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // "${data['name']}"
                                        //     .text
                                        //     .fontFamily(bold)
                                        //     .white
                                        //     .make(),
                                        "${data['email']}".text.white.make(),
                                      ],
                                    )),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: whiteColor,
                                        )),
                                    onPressed: () async {
                                      await Get.put(AuthController())
                                          .signoutMethod(context);
                                      Get.offAll(() => const LoginScreen());
                                    },
                                    child: logout.text
                                        .fontFamily(bold)
                                        .white
                                        .make())
                              ],
                            ),
                          ),
                          20.heightBox,
                          FutureBuilder(future: FirestorServices.getCounts(),
                              builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(!snapshot.hasData){
                              return Center(child: loadingIndicator());
                            }else{
                              var countData = snapshot.data!;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  detailsCard(context.screenWidth / 3.2,
                                      data['cart_count'], "in your cart"),
                                  detailsCard(context.screenWidth / 3.2,
                                      data['wishlist'], "your wishlist"),
                                  detailsCard(context.screenWidth / 3.2,
                                      countData.toString(), "your orders")
                                ],
                              );
                            }

                              }),
                          ListView
                              .separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: lightGrey,
                              );
                            },
                            itemCount: profileButtonsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const OrderScreen());
                                      break;
                                    case 1:
                                      Get.to(() => const WishlistScreen());
                                  }
                                },
                                leading: Image.asset(
                                  profileButtonsIcon[index],
                                  width: 22,
                                ),
                                title: profileButtonsList[index]
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            },
                          )
                              .box
                              .white
                              .rounded
                              .margin(const EdgeInsets.all(12))
                              .padding(
                              const EdgeInsets.symmetric(horizontal: 16))
                              .shadowSm
                              .make()
                              .box
                              .color(redColor)
                              .make()
                        ],
                      ),
                    );
                  }
                })));
  }
}
