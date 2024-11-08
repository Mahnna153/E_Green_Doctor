class HomeModel {
  int? count;
  List<Plants>? plants;

  HomeModel({this.count, this.plants});

  HomeModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['plants'] != null) {
      plants = <Plants>[];
      json['plants'].forEach((v) {
        plants!.add(Plants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    if (plants != null) {
      data['plants'] = plants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plants {
  String? name;
  String? plantImage;
  String? sId;
  Request? request;

  Plants({this.name, this.plantImage, this.sId, this.request});

  Plants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    plantImage = json['plantImage'];
    sId = json['_id'];
    request =
        json['request'] != null ? Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['plantImage'] = plantImage;
    data['_id'] = sId;
    if (request != null) {
      data['request'] = request!.toJson();
    }
    return data;
  }
}

class Request {
  String? type;
  String? url;

  Request({this.type, this.url});

  Request.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
