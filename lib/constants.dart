// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

/* 00977716007 */
/* 10203040 */
class Constants {
  Constants._();
  static String baseUrl = '';
  static const double padding = 20;
  static const double paddingAll = 8;
  static const double avatarRadius = 45;
  static const double radius = 10;

  static const Map<String, dynamic> dados = {
    "colors": {
      "primary": Color(0xFF212327),
      "secondary": Color(0xFFFFFFF7),
      "gray1": Color(0xFF505050),
      "backgroundGrey": Color.fromARGB(255, 224, 222, 222),
      "1": Color(0xfff0496ff),
      "2": Color(0xfff19e0a3),
      "3": Color(0xfff983fff),
      "4": Color(0xffffee354),
      "5": Color(0x0fff814c),
      "6": Color(0x0fff5251),
    },
    "redeSociais": {
      "facebook": {"id": "daufencondominios", "nome": "daufencondominios"},
      "instagram": {"id": "daufencondominios", "nome": "daufencondominios"},
      "whatsapp": {"numero": "5554991715022"}
    },
  };
}
