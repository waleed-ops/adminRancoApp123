import 'package:firebase_core/firebase_core.dart';

class ItemModel {
   String name;
   String email;
   String VisitDate;
   String villaNum;
   String dateCreated;
   String guestName;
   String guestStatus;
   String uid;
   String getUserName;
   String guestUid;
   String FFFFFFFF;
   String guestId;
   String guestNationality;
   String guestUnitNum;
   String problem;
   String UnitNumber;
   String maintenanceId;
   String MaintenanceStatus;

  ItemModel({
     this.name,
     this.email,
     this.VisitDate,
     this.dateCreated,
     this.villaNum,
     this.guestName,
     this.guestStatus,
     this.uid,
     this.guestUid,
     this.getUserName,
     this.FFFFFFFF,
     this.maintenanceId,
     this.guestId,
     this.guestNationality,
     this.guestUnitNum,
     this.UnitNumber,
     this.problem,
     this.MaintenanceStatus,
        });

  ItemModel.fromJson(Map<String, dynamic> json) {
    Firebase.initializeApp();
    name = json['name'];
    email = json['email'];
    dateCreated = json['dateCreated'];
    villaNum = json['villaNum'];
    VisitDate = json['VisitDate'];
    getUserName = json['getUserName'];
    guestName = json['guestName'];
    guestUnitNum = json['guestUnitNum'];
    FFFFFFFF = json['FFFFFFFF'];
    maintenanceId = json['maintenanceId'];
    guestStatus = json['guestStatus'];
    uid = json['uid'];
    guestUid = json['guestUid'];
    guestId = json['guestId'];
    UnitNumber = json['UnitNumber'];
    guestNationality = json['guestNationality'];
    problem = json['problem'];
    MaintenanceStatus = json['MaintenanceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['guestName'] = this.guestName;
    if (this.VisitDate != null) {
      data['date'] = this.VisitDate;
    }
    data['VisitDate'] = this.VisitDate;
    data['villaNum'] = this.villaNum;
    data['maintenanceId'] = this.maintenanceId;
    data['guestUnitNum'] = this.guestUnitNum;
    data['FFFFFFFF'] = this.FFFFFFFF;
    data['getUserName'] = this.getUserName;
    data['UnitNumber'] = this.UnitNumber;
    data['guestStatus'] = this.guestStatus;
    data['dateCreated'] = this.dateCreated;
    data['uid'] = this.uid;
    data['guestUid'] = this.guestUid;
    data['guestNationality'] = this.guestNationality;
    data['guestId'] = this.guestId;
    data['problem'] = this.problem;
    data['MaintenanceStatus'] = this.MaintenanceStatus;
    return data;
  }
}

class VisitDate {
  String date;

  VisitDate({this.date});

  VisitDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
