import 'package:pc_build_assistant/models/pc_component.dart';

class ComponentDetails {
  List<String> getComponentDetails(PCComponent component) {
    List<String> details = [];
    details.add(component.description);
    return details;
  }
}
