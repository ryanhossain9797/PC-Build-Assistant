import 'package:flutter/cupertino.dart';
import 'package:pc_build_assistant/models/pc_component.dart';

class PCMotherboard extends PCComponent {
  final int size;

  PCMotherboard({
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
