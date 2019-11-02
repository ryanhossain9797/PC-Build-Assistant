import 'package:pc_build_assistant/models/pc_component.dart';

class PCChassis extends PCComponent {
  final String size;

  PCChassis({
    String manufacturer,
    String name,
    String description,
    String imgurl,
    this.size,
  }) : super(
          manufacturer: manufacturer,
          name: name,
          description: description,
          imgurl: imgurl,
        );
}
