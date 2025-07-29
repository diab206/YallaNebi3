import 'package:flutter/material.dart';

Future<dynamic> navigteTo(BuildContext context, Widget view) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}
