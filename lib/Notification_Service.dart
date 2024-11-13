import 'package:firebase_messaging/firebase_messaging.dart';




class Notifications{
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<String?> getFCMToken() async {
    // Get FCM token
    String? token = await _messaging.getToken();

    // Print the token to the console for debugging
    print("token  $token");

    return token;  // Return the token
  }



  Future<void> initialized() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print('receive message: ${message.notification?.title}, ${message.notification?.body}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print('open notification: ${message.notification?.title}, ${message.notification?.body}');
    });

  }

}