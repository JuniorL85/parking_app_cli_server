abstract class Networked<T> {
  String host;
  String port;
  String resource;

  Map<String, dynamic> serialize(T item);
  T deserialize(Map<String, dynamic> json);

  Networked(
      {required this.resource,
      this.host = 'http://localhost',
      this.port = '8080'});
}
