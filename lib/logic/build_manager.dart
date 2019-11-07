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
  static int _itemCount = 0;
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

  static int getItemCount() {
    int count = 0;
    if (build.chassis != null) count++;
    if (build.motherboard != null) count++;
    if (build.processor != null) count++;
    if (build.gpu != null) count++;
    if (build.psu != null) count++;
    print("$count items");
    return count;
  }

  static getBuild() {}
  static removeComponent(PCComponent component) {
    if (component is PCGraphicsProcessor) {
      build.gpu = null;
    } else if (component is PCProcessor) {
      build.processor = null;
    } else if (component is PCPowerSupply) {
      build.psu = null;
    } else if (component is PCMotherboard) {
      build.motherboard = null;
    } else if (component is PCChassis) {
      build.chassis = null;
    }
    print(removeComponent);
  }

  static getItem(int index) {
    int count = 0;
    if (build.chassis != null) {
      if (count == index) {
        return build.chassis;
      } else {
        count++;
      }
    }
    if (build.motherboard != null) {
      if (count == index) {
        return build.motherboard;
      } else {
        count++;
      }
    }
    if (build.processor != null) {
      if (count == index) {
        return build.processor;
      } else {
        count++;
      }
    }
    if (build.gpu != null) {
      if (count == index) {
        return build.gpu;
      } else {
        count++;
      }
    }
    if (build.psu != null) {
      if (count == index) {
        return build.psu;
      } else {
        count++;
      }
    }
  }
}
