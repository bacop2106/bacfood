import 'package:flutter/services.dart';
import 'package:foodonlineapapp/consts/consts.dart';
import 'package:foodonlineapapp/widget_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(redColor, whiteColor, "Yes", () {
              SystemNavigator.pop();
            }),
            ourButton(redColor, whiteColor, "No", () {
              Navigator.pop(context);
            }),
          ],
        )
      ],
    ).box.color(lightGrey).roundedSM.padding(const EdgeInsets.all(12)).make(),
  );
}
