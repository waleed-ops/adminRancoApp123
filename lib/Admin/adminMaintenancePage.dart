import 'package:admin_ranco_app/DialogBox/errorDialog.dart';
import 'package:admin_ranco_app/Models/item.dart';
import 'package:admin_ranco_app/Widgets/loadingWidget.dart';
import 'package:admin_ranco_app/Widgets/searchBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'adminDrawer.dart';

class AdminMaintenancePage extends StatefulWidget {
  @override
  _AdminMaintenancePage createState() => _AdminMaintenancePage();
}

class _AdminMaintenancePage extends State<AdminMaintenancePage> {
  List<Color> _colors = [
    Colors.blue.shade300,
    Colors.deepPurpleAccent.shade100
  ];
  String _maintenanceIsDone = "Done";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: _colors,
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
          "Ranco App",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collectionGroup("maintenance")
                .orderBy("MaintenanceStatus", descending: true)
                .snapshots(),
            builder: (context, dataSnapshot) {
              return !dataSnapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        ItemModel model = ItemModel.fromJson(
                            // dataSnapshot.data.docs[index].data());
                            dataSnapshot.data.docs[index].data());
                        print("This is something" + model.toString());
                        return sourceInfo(model, context, background: null);
                      },
                      itemCount: dataSnapshot.data.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget sourceInfo(ItemModel model, BuildContext context,
      {Color background, removeCarFunction}) {
    return InkWell(
      splashColor: Colors.pink,
      child: Padding(
        padding: EdgeInsets.all(7.0),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: new LinearGradient(
              colors: [Colors.blue[300], Colors.deepPurpleAccent[100]],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 5.0,
              ),
              Image.asset(
                "images/icons/person.png",
                width: 60.0,
                height: 60.0,
                color: Colors.white,
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                "Name: " + model.getUserName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                "Unit Number: " + model.villaNum,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                "Problem: " + model.problem,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                "" + model.MaintenanceStatus,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 13.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10.0, top: 3.0, left: 3.0),
                    child: ElevatedButton(
                      onPressed: () {
                        acceptMaintenanceRequest(model);
                      },
                      child: Text(
                        "Accept",
                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // <-- Radius
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  //
  // Accept Guest Request
  void acceptMaintenanceRequest(ItemModel model) {
    print("This is model " + model.name);
    if (model.maintenanceId != null) {
      if (model.MaintenanceStatus == "Pending") {
        print(model.maintenanceId);
        displayDialog("Maintenance was Accepted!!!");
        FirebaseFirestore.instance
            .collection("maintenance")
            .doc(model.guestUid)
            .collection("maintenance")
            .doc(model.maintenanceId)
            .update({"MaintenanceStatus": _maintenanceIsDone});
      } else {
        displayDialog("Maintenance Already Accepted!!!");
      }
    } else {
      print("Something is wrong, please restart the app");
    }
  }
}
