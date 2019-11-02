import '../models/pc_component.dart';

class FakeDataBase {
  static List<PCComponent> fakeComponents = [
    PCComponent(
      manufacturer: "EVGA",
      name: "GTX 780ti",
      description: "VRAM: 3GB",
      imgurl:
          'https://www.evga.com/articles/00795/images/hero/780Ti_HeroCombo.png',
    )
  ];
}
