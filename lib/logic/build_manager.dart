//import 'package:pc_build_assistant/models/pc_chs.dart';
import 'package:pc_build_assistant/models/build.dart';
import 'package:pc_build_assistant/models/pc_chs.dart';
import 'package:pc_build_assistant/models/pc_component.dart';
import 'package:pc_build_assistant/models/pc_cpu.dart';
import 'package:pc_build_assistant/models/pc_gpu.dart';
import 'package:pc_build_assistant/models/pc_mbd.dart';
import 'package:pc_build_assistant/models/pc_psu.dart';

class BuildManager {
  static Build build = Build();

  static void addComponent(PCComponent component) {
    if (component is PCGraphicsProcessor) {
      build.gpu = component;
      print("GPU");
    } else if (component is PCProcessor) {
      build.processor = component;
      print("CPU");
    } else if (component is PCPowerSupply) {
      build.psu = component;
      print("PSU");
    } else if (component is PCMotherboard) {
      build.motherboard = component;
      print("Motherboard");
    } else if (component is PCChassis) {
      build.chassis = component;
      print("Chassis");
    }
    print(build);
  }

  static getBuild() {}
  static removeComponent(PCComponent removeComponent) {
    print(removeComponent);
  }
}
