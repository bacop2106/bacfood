import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/controllers/auth_controller.dart';
import 'package:foodonlineapapp/views/home_screen/home.dart';
import 'package:get/get.dart';

import '../../widget_common/applogo_widget.dart';
import '../../widget_common/bg_widget.dart';
import '../../widget_common/custom_textfield.dart';
import '../../widget_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).black.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(name, nameHint, nameController, false),
                  customTextField(email, emailHint, emailController, false),
                  customTextField(
                      password, passwordHint, passwordController, true),
                  customTextField(retypePassword, passwordHint,
                      passwordRetypeController, true),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: " I agree to the",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: termAndCord,
                                style: TextStyle(
                                    fontFamily: bold, color: redColor)),
                            TextSpan(
                                text: " &",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  5.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(isCheck == true ? redColor : whiteColor,
                          whiteColor, signup, () async {
                          if (isCheck != false) {
                            controller.isloading(true);
                            try {
                              await controller
                                  .signiupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              )
                                  .then((value) {
                                return controller.storeUserData(
                                    nameController.text,
                                    passwordController.text,
                                    emailController.text);
                              }).then((value) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isloading(false);
                            }
                          }
                        }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: alreadyHaveAccount,
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )),
                        TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: redColor,
                          ),
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Get.back();
                  })
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 50)
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
