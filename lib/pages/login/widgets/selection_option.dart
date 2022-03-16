import 'package:flutter/material.dart';
import 'package:mob_whatsapp/pages/login/models/country_model.dart';

class SelectionOption extends StatelessWidget {
  final Color? textColor;
  final CountryModel? country;

  const SelectionOption({
    Key? key,
    this.textColor,
    required this.country
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xffdbdbdc)
          ),
          top: BorderSide(
            width: 1,
            color: Color(0xffdbdbdc)
          ),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text(
              country!.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor ?? const Color(0xff000000)
              ),
            ),
            const Icon(
              Icons.chevron_right_outlined,
              color: Color(0xffdbdbdc),
            )
          ],
        ),
      ),
    );
  }
}