import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger_clone/helperfunctions/sharedpref_helper.dart';
import 'dart:convert';

class DatabaseMethods {
  Future<void> addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  Future<void> updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  Future<bool> createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exist
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
      return true;
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String? myUsername = await SharedPreferenceHelper().getUserName();
    if (myUsername != null) {
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .orderBy("lastMessageSendTs", descending: true)
          .where("users", arrayContains: myUsername)
          .snapshots();
    } else {
      throw Exception("Username is null");
    }
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      // Read the file as bytes
      List<int> imageBytes = await imageFile.readAsBytes();

      // Convert the bytes to base64 string
      String base64Image = base64Encode(imageBytes);

      // Save the base64 encoded image directly to the `stories` collection in Firestore
      await FirebaseFirestore.instance.collection('stories').add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'imgUrl': base64Image,
        'timestamp': FieldValue.serverTimestamp(),
      });

      return base64Image;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getStories() async {
    try {
      // Query the 'stories' collection in Firestore
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('stories').get();

      // Extract the URLs and timestamps of the stories from the snapshot
      List<Map<String, dynamic>> stories = [];
      snapshot.docs.forEach((doc) {
        stories.add({
          'imgUrl': doc.data()['imgUrl'],
          'timestamp': (doc.data()['timestamp'] as Timestamp)
              .toDate(), // Convert Firestore timestamp to Dart DateTime
        });
      });

      return stories;
    } catch (e) {
      print('Error fetching stories: $e');
      return [];
    }
  }
}
