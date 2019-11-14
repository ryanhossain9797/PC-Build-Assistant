import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pc_build_assistant/models/pc_chs.dart';
import 'package:pc_build_assistant/models/pc_component.dart';
import 'package:pc_build_assistant/models/pc_cpu.dart';
import 'package:pc_build_assistant/models/pc_gpu.dart';
import 'package:pc_build_assistant/models/pc_mbd.dart';
import 'package:pc_build_assistant/models/pc_psu.dart';

class DatabaseHelper {
  static Firestore _database = Firestore.instance;

  static getData() async {
    List<PCComponent> components = new List<PCComponent>();
    try {
      List<Map<String, dynamic>> componentList;
      QuerySnapshot collection =
          await _database.collection('pc-components').getDocuments();
      List<DocumentSnapshot> documents = collection.documents;
      componentList = documents.map((DocumentSnapshot snapshot) {
        return snapshot.data;
      }).toList();
      components.clear();
      for (Map<String, dynamic> item in componentList) {
        switch (item["type"]) {
          case "cpu":
            components.add(
              PCProcessor(
                manufacturer: item["manufacturer"],
                name: item["name"],
                description: item["description"],
                imgurl: item["imgurl"],
              ),
            );
            break;
          case "gpu":
            components.add(
              PCGraphicsProcessor(
                manufacturer: item["manufacturer"],
                name: item["name"],
                description: item["description"],
                imgurl: item["imgurl"],
              ),
            );
            break;
          case "chs":
            components.add(
              PCChassis(
                manufacturer: item["manufacturer"],
                name: item["name"],
                description: item["description"],
                imgurl: item["imgurl"],
                size: item["size"],
              ),
            );
            break;
          case "mbd":
            components.add(
              PCMotherboard(
                manufacturer: item["manufacturer"],
                name: item["name"],
                description: item["description"],
                imgurl: item["imgurl"],
                size: item["size"],
              ),
            );
            break;
          case "psu":
            components.add(
              PCPowerSupply(
                manufacturer: item["manufacturer"],
                name: item["name"],
                description: item["description"],
                imgurl: item["imgurl"],
              ),
            );
            break;
          default:
            components.add(
              PCComponent(
                manufacturer: item["manufacturer"],
                name: item["name"],
                description: item["description"],
                imgurl: item["imgurl"],
              ),
            );
            break;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return components;
  }
}
