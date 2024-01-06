import 'package:foodonlineapapp/consts/consts.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        10.heightBox,
        title!.text.fontFamily(bold).color(darkFontGrey).make(),
      ],
    ),
  ).box.rounded.white.size(width, height).shadowSm.make();
}
