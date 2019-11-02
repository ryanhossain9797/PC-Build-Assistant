//import 'package:pc_build_assistant/models/pc_chs.dart';
import 'package:pc_build_assistant/models/pc_chs.dart';
import 'package:pc_build_assistant/models/pc_component.dart';
import 'package:pc_build_assistant/models/pc_cpu.dart';
import 'package:pc_build_assistant/models/pc_gpu.dart';
import 'package:pc_build_assistant/models/pc_mbd.dart';
import 'package:pc_build_assistant/models/pc_psu.dart';
//import 'package:pc_build_assistant/models/pc_cpu.dart';
//import 'package:pc_build_assistant/models/pc_gpu.dart';
//import 'package:pc_build_assistant/models/pc_mbd.dart';
//import 'package:pc_build_assistant/models/pc_psu.dart';

class BuildManager {
  static void addComponent(PCComponent component) {
    if (component is PCGraphicsProcessor) {
      print("GPU");
    } else if (component is PCProcessor) {
      print("CPU");
    } else if (component is PCPowerSupply) {
      print("PSU");
    } else if (component is PCMotherboard) {
      print("Motherboard");
    } else if (component is PCChassis) {
      print("Chassis");
    }
  }
}
