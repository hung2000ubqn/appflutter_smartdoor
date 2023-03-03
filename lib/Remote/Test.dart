class Test {
  final String idRemote;
  final String id;
  final int data;

  Test({required this.id,required this.data,required this.idRemote});

  factory Test.fromJson(Map<String, dynamic> parsedJson) {
    final idFromJson = parsedJson['id'] as String;
    //var streetsFromJson = parsedJson['streets'];
    //List<String> streetsList = new List<String>.from(streetsFromJson);

    //print(streetsFromJson.runtimeType);
    //List<String> streetsList = new List<String>.from(streetsFromJson);

    final data = parsedJson['control_data'] as int;
    final idRemoteFromJson = parsedJson['id_remote'] as String;


    return Test(id: idFromJson,data: data, idRemote: idRemoteFromJson);
  }
}