import 'package:admin_ranco_app/DialogBox/errorDialog.dart';
import 'package:admin_ranco_app/Models/item.dart';
import 'package:admin_ranco_app/Widgets/loadingWidget.dart';
import 'package:admin_ranco_app/Widgets/searchBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'adminDrawer.dart';

class guestsRequested extends StatefulWidget {
  @override
  _guestsRequested createState() => _guestsRequested();
}

class _guestsRequested extends State<guestsRequested> {
  String _rcceptGuestStatus = "Accepted";
  String _rejectGuestStatus = "Rejected";
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.blue[300], Colors.deepPurpleAccent[100]],
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
                .collectionGroup("guests")
                .where("guestStatus", isEqualTo: "Pending")
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
                            dataSnapshot.data.docs[index].data());
                        print("This is something" + model.toString());
                        return sourceInfo(model, context);
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
              // Expanded(
              //   child: Column(
              //     children: [
              //       Container(
              //         child: Text(
              //           "Guest Name: " + model.guestName,
              //           style: TextStyle(color: Colors.white, fontSize: 17.0),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Image.asset(
              //   "images/person.png",
              //   width: 60.0,
              //   height: 60.0,
              //   color: Colors.white,
              // ),
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
                                "Guest Name: " + model.guestName,
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
                                "Villa Owner: " + model.getUserName,
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
                                "Villa Number: " + model.villaNum,
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
                                "Guest ID: " + model.villaNum,
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
                                "Visit Date: " + model.VisitDate,
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
                                "" + model.guestStatus,
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
                        acceptGuestRequest(model);
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
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, left: 3.0, bottom: 3.0),
                    child: ElevatedButton(
                      onPressed: () {
                        regectGuestRequest(model);
                      },
                      child: Text(
                        "Reject",
                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
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

  //Show Dialog
  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  // Accept Guest Request
  void acceptGuestRequest(ItemModel model) {
    print("This is model " + model.guestName);
    if (model.FFFFFFFF != null) {
      print(model.FFFFFFFF);
      displayDialog("Guest was Accepted!!!");
      FirebaseFirestore.instance
          .collection("guests")
          .doc(model.guestUid)
          .collection("guests")
          .doc(model.FFFFFFFF)
          .update({"guestStatus": _rcceptGuestStatus});
    } else {
      print("Something is wrong, please restart the app");
    }
  }

  // Regect Guest Request
  void regectGuestRequest(ItemModel model) {
    if (model.FFFFFFFF != null) {
      print(model.FFFFFFFF);
      displayDialog("Guest was Rejected!!!");
      FirebaseFirestore.instance
          .collection("guests")
          .doc(model.guestUid)
          .collection("guests")
          .doc(model.FFFFFFFF)
          .update({"guestStatus": _rejectGuestStatus});
    } else {
      print("Something is wrong, please restart the app");
    }
  }
}
