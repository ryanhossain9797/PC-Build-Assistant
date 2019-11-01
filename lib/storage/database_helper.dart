import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pc_build_assistant/models/pc_component.dart';

class DatabaseHelper {
  static Firestore _database = Firestore.instance;

  static getData() async {
    List<PCComponentModel> components = new List<PCComponentModel>();
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
        components.add(
          PCComponentModel(
            manufacturer: item["manufacturer"],
            name: item["name"],
            description: item["description"],
            imgurl: item["imgurl"],
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
    return components;
  }
}
