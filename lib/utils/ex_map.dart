extension MapExtension on Map {
  //qr sign 加密排序
  String sortSignParam() {
    if (this.isNotEmpty) {
      List<MapEntry<String, dynamic>> conversionList = this.entries.toList();
      conversionList.sort((a, b) {
        return a.key.compareTo(b.key);
      });
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < conversionList.length; i++) {
        buffer.write("${conversionList[i].key}=${conversionList[i].value}");
        if (i != conversionList.length - 1) {
          buffer.write("&");
        }
      }
      return buffer.toString();
    } else {
      return null;
    }
  }
}
