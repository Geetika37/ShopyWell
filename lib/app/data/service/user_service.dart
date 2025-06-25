import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/data/models/user_model.dart';

class UserService extends GetxService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final userCache = <String, UserModel>{}.obs;

  Future<void> loadUsers() async {
    try {
      if (auth.currentUser == null) return;
      final snapshot = await firestore.collection('users').get();

      for (var doc in snapshot.docs) {
        final userData = doc.data();
        userData['uid'] = doc.id; // Ensure uid is set
        final user = UserModel.fromJson(userData);
        userCache[doc.id] = user;
      }
    } catch (e) {
      debugPrint('Error loading users: $e');
    }
  }

  // Get user by ID (from cache)
  UserModel? getUser(String userId) {
    return userCache[userId];
  }

  // // Get user name by ID (from cache)
  // String getUserName(String userId) {
  //   return userCache[userId]?.name ?? '';
  // }

  // Get all users (from cache)
  List<UserModel> getAllUsers() {
    return userCache.values.toList();
  }

  // // Check if user is admin
  // bool isUserAdmin(String userId) {
  //   final user = userCache[userId];
  //   return user?.role == 'manager';
  // }

  @override
  void onInit() {
    super.onInit();
    loadUsers(); // Load users when service initializes
  }

  // Refresh cache manually if needed
  // Future<void> refreshUserCache() async {
  //   userCache.clear();
  //   await loadUsers();
  // }
}
