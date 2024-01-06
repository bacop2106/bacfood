import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/consts/lits.dart';
import 'package:foodonlineapapp/controllers/auth_controller.dart';
import 'package:foodonlineapapp/views/auth_screen/signup_screen.dart';
import 'package:foodonlineapapp/views/home_screen/home.dart';
import 'package:foodonlineapapp/widget_common/applogo_widget.dart';
import 'package:foodonlineapapp/widget_common/bg_widget.dart';
import 'package:foodonlineapapp/widget_common/custom_textfield.dart';
import 'package:foodonlineapapp/widget_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // var emailController = TextEditingController();
  // var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).black.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      email, emailHint, controller.emailController, false),
                  customTextField(password, passwordHint,
                      controller.passwordController, true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  5.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(redColor, whiteColor, login, () async {
                          controller.isloading(true);
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(() => const Home());
                            } else {
                              controller.isloading(false);
                            }
                          });
                        }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(lightGrey, redColor, signup, () {
                    Get.to(() => const SignupScreen());
                  }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  )
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
