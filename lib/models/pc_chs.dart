import 'package:flutter/foundation.dart';
import 'package:pc_build_assistant/models/pc_component.dart';

class PCChassis extends PCComponent {
  final int size;

  PCChassis({
    String manufacturer,
    String name,
    String description,
    String imgurl,
    @required this.size,
  }) : super(
          manufacturer: manufacturer,
          name: name,
          description: description,
          imgurl: imgurl,
        );
}
