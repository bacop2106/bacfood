import 'package:foodonlineapapp/consts/consts.dart';

Widget ourButton(color, textColor, String? title, onPress) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color, padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
