class Remote {
  final String idRemote;
  final int fireStatus;
  final int data;

  Remote({required this.data,required this.fireStatus,required this.idRemote});

  factory Remote.fromJson(Map<String, dynamic> parsedJson) {


    final data = parsedJson['control_data'] as int;
    final fireStatus = parsedJson['fire_s'] as int;
    final idRemoteFromJson = parsedJson['id_remote'] as String;

    return Remote(data: data, fireStatus: fireStatus, idRemote: idRemoteFromJson);
  }
}