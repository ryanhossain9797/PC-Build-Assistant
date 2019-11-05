import 'package:pc_build_assistant/models/pc_chs.dart';
import 'package:pc_build_assistant/models/pc_cpu.dart';
import 'package:pc_build_assistant/models/pc_gpu.dart';
import 'package:pc_build_assistant/models/pc_mbd.dart';
import 'package:pc_build_assistant/models/pc_psu.dart';

class Build {
  PCChassis chassis;
  PCMotherboard motherboard;
  PCProcessor processor;
  PCGraphicsProcessor gpu;
  PCPowerSupply psu;

  Build({this.chassis, this.motherboard, this.processor, this.gpu, this.psu});

  @override
  String toString() {
    return "$chassis $motherboard $processor $gpu $psu";
  }
}
