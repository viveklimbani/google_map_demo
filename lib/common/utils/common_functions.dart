import 'package:flutter/material.dart';

import '../../data/selected_address_location.dart';

SelectedAddressLocation selectedAddressLocation = SelectedAddressLocation();

dismissKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

