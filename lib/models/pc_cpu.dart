import 'package:pc_build_assistant/models/pc_component.dart';

class PCProcessor extends PCComponent {
  PCProcessor({
    String manufacturer,
    String name,
    String description,
    String imgurl,
  }) : super(
          manufacturer: manufacturer,
          name: name,
          description: description,
          imgurl: imgurl,
        );
}
