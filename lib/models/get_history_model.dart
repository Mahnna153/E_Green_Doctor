class GetHistoryModel {
  int? count;
  List<History>? history;

  GetHistoryModel({this.count, this.history});

  GetHistoryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? sId;
  String? useremail;
  String? diseaseName;
  String? diseaseDesciption;
  String? diseasePhoto;
  String? diseaseCure;
  String? date;
  int? iV;

  History(
      {this.sId,
      this.useremail,
      this.diseaseName,
      this.diseaseDesciption,
      this.diseasePhoto,
      this.diseaseCure,
      this.date,
      this.iV});

  History.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    useremail = json['useremail'];
    diseaseName = json['diseaseName'];
    diseaseDesciption = json['diseaseDesciption'];
    diseasePhoto = json['diseasePhoto'];
    diseaseCure = json['diseaseCure'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['useremail'] = this.useremail;
    data['diseaseName'] = this.diseaseName;
    data['diseaseDesciption'] = this.diseaseDesciption;
    data['diseasePhoto'] = this.diseasePhoto;
    data['diseaseCure'] = this.diseaseCure;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}
