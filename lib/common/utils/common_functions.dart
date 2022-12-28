import 'package:flutter/material.dart';

import '../../data/selected_address_location.dart';

SelectedAddressLocation selectedAddressLocation = SelectedAddressLocation();

dismissKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

Widget errorWidget(String? errorText, {EdgeInsets? margin}) {
  return (errorText == null || errorText.isEmpty)
      ? Container()
      : Container(
    margin: margin ?? const EdgeInsets.all(0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            errorText,
            style: const TextStyle(color: Colors.red)
        ),
      ],
    ),
  );
}