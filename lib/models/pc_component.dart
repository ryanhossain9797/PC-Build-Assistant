import 'package:pc_build_assistant/models/pc_chs.dart';
import 'package:pc_build_assistant/models/pc_cpu.dart';
import 'package:pc_build_assistant/models/pc_gpu.dart';
import 'package:pc_build_assistant/models/pc_mbd.dart';
import 'package:pc_build_assistant/models/pc_psu.dart';

class PCComponent {
  final String manufacturer;
  final String name;
  final String description;
  final String imgurl;
  PCComponent({this.manufacturer, this.name, this.description, this.imgurl});

  @override
  String toString() {
    return "\n$manufacturer $name";
  }

  static String getTitle(PCComponent component) {
    if (component is PCGraphicsProcessor) {
      return "Graphics Card";
    } else if (component is PCProcessor) {
      return "Processor";
    } else if (component is PCPowerSupply) {
      return "Power Supply";
    } else if (component is PCMotherboard) {
      return "Motherboard";
    } else if (component is PCChassis) {
      return "Chassis";
    }
    return "Title";
  }
}
