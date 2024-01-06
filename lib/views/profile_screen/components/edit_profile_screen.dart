import 'dart:io';

import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/controllers/profile_controller.dart';
import 'package:foodonlineapapp/widget_common/bg_widget.dart';
import 'package:foodonlineapapp/widget_common/custom_textfield.dart';
import 'package:foodonlineapapp/widget_common/our_button.dart';
import 'package:get/get.dart';

class EditProflieScreen extends StatelessWidget {
  final dynamic data;

  const EditProflieScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(redColor, whiteColor, "Change", () {
              controller.changeImage(context);
              // Get.find<ProfileController>().changeImage(context);
            }),
            20.heightBox,
            customTextField(name, nameHint, controller.nameController, false),
            10.heightBox,
            customTextField(
                oldpass, passwordHint, controller.oldpassController, true),
            10.heightBox,
            customTextField(
                newpass, passwordHint, controller.newpassController, true),
            20.heightBox,
            if (controller.isloading.value) const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ) else SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(redColor, whiteColor, "Save", () async {
                      controller.isloading(true);
                      // image not selected
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImgLink = data['imageUrl'];
                      }
                      if (data['password'] ==
                          controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldpassController.text,
                            newpassword: controller.newpassController.text);

                        await controller.updateProfile(
                            controller.nameController.text,
                            controller.newpassController.text,
                            controller.profileImgLink);
                        VxToast.show(context, msg: "Update");
                      } else {
                        VxToast.show(context, msg: "Wrong old password");
                        controller.isloading(false);
                      }
                    }),
                  )
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
