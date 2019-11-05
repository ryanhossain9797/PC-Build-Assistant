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
}
