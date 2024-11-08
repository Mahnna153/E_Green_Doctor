class AddHistoryModel {
  Resu? resu;

  AddHistoryModel({this.resu});

  AddHistoryModel.fromJson(Map<String, dynamic> json) {
    resu = json['resu'] != null ? new Resu.fromJson(json['resu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resu != null) {
      data['resu'] = this.resu!.toJson();
    }
    return data;
  }
}

class Resu {
  String? sId;
  String? useremail;
  String? diseaseName;
  String? diseaseDesciption;
  String? diseasePhoto;
  String? diseaseCure;
  String? date;
  int? iV;

  Resu(
      {this.sId,
      this.useremail,
      this.diseaseName,
      this.diseaseDesciption,
      this.diseasePhoto,
      this.diseaseCure,
      this.date,
      this.iV});

  Resu.fromJson(Map<String, dynamic> json) {
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
