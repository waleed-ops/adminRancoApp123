import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AdminRancoApp {
   static const String appName = 'RancoApp';

   static SharedPreferences sharedPreferences;
   static User user;
   static FirebaseAuth auth;
   static FirebaseFirestore firestore ;

   static String collectionUser = "users";
   static String collectionOrders = "orders";
   static String userCartList = 'userCart';
   static String subCollectionAddress = 'userAddress';

   static final String userName = 'name';
   static final String adminName = 'adminName';
   static final String userEmail = 'email';
   static final String userPhotoUrl = 'photoUrl';
   static final String userUID = 'uid';

   static final String guestUID = 'guestuid';
   static final String guestName = 'guestName';
   static final String TokenId = 'tokenId';
   static final String guestStatus = 'guestStatus';
   static final String guestID = 'guestID';
   static final String guestDate = 'guestDate';


   static final String unitNum = 'unitNum';
   static final String natinality = 'natinality';
   static final String userAvatarUrl = 'url';
   static final String userdate = 'date';

   static final String addressID = 'addressID';
   static final String totalAmount = 'totalAmount';
   static final String productID = 'productIDs';
   static final String paymentDetails ='paymentDetails';
   static final String orderTime ='orderTime';
   static final String isSuccess ='isSuccess';

}