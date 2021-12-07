const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();


//For Accepting or Rejecting Notification
exports.GuestWasAdded =functions.firestore.document('guests/{guestUid}/guests/{FFFFFFFF}')
.onCreate((change, context) =>{

const guestUid = context.params.guestUid;
const FFFFFFFF = context.params.FFFFFFFF;

console.log('The User id is : ', FFFFFFFF);
console.log('The User Guest id is : ', guestUid);

return admin.firestore().collection("guests").doc(guestUid).get().then(queryResult => {
//    const tokenId = queryResult.data().TokenId;
    const tokenId = "cqrsy3NESfWJCj1V4HL8Ex:APA91bH1IswNP9Cpq_FlAGX_Xu45_TCmzDSaCfl0EozdyERA7Wmnsqqla4-MIo-GIJJS0aQHM9VQG0cgd0NYOxiHUhIZZQr2lBupLgTPz7MFoDgUZgmT7xQ1vHAf-JA4kc9Sg5y8sZQO";
    console.log('The User Token Number : ', tokenId);
//    const guestStatus = queryResult.data().guestStatus;
//    console.log('Guest Status  : ', guestStatus);
//    const guestName = queryResult.data().guestName;

//    if(guestStatus == "Accepted"){
//        const notificationContent = {
//            notification:{
//            title: "Guest " + guestName + " Was Accepted",
//            body: "For any questions, contact Security."
//            }
//        };
//        return admin.messaging().sendToDevice(tokenId, notificationContent).then(result => {
//          console.log("Notification sent!");
//        });
//    }
//
//    if(guestStatus == "Rejected"){
         const notificationContent = {
            notification:{
            title: "Guest Was Requested",
            body: "Please Check Guests Page."
            }

         };
//        return admin.messaging().sendToDevice(tokenId, notificationContent).then(result => {
//           console.log("Notification sent!");
//        });
//    }

    return admin.messaging().sendToDevice(tokenId, notificationContent).then(result => {
              console.log("Notification sent!");
            });

   });
});

//For Maintenance
//exports.MinantanceDoneNotification=functions.firestore.document('maintenance/{guestUid}/maintenance/{maintenanceId}')
//.onWrite((change, context) =>{
//const UserUid = context.params.guestUid;
//const maintenanceId = context.params.maintenanceId;
//console.log('The User id is : ', UserUid);
//console.log('The User Maintenance request id is : ', maintenanceId);
//
//return admin.firestore().collection("maintenance").doc(UserUid).collection("maintenance").doc(maintenanceId).get().then(queryResult => {
//    const tokenId = queryResult.data().TokenId;
//    console.log('The User Token Number : ', tokenId);
//    const MaintenanceStatus = queryResult.data().MaintenanceStatus;
//    console.log('Maintenance Status  : ', MaintenanceStatus);
//    const name = queryResult.data().name;
//
//    if(MaintenanceStatus == "Done"){
//        const notificationContent = {
//            notification:{
//            title: + name + "Maintenance Was marked Done",
//            body: "Maintenance was marked as done."
//            }
//        };
//        return admin.messaging().sendToDevice(tokenId, notificationContent).then(result => {
//          console.log("Notification sent!");
//        });
//    }
//
//   });
//});