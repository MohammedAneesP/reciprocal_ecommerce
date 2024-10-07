import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddingeOrders {
  Future<void> addingorders(
      {required Map<String, dynamic> anMap, required String anEmail}) async {
    try {
      final anValue =
          await FirebaseFirestore.instance.collection("orders").get();
      final now = DateTime.now().toString();
      anMap["document id"] = now;

      if (anValue.docs.isEmpty) {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(now)
            .set(anMap);
        await FirebaseFirestore.instance
            .collection("cart")
            .doc(anEmail)
            .delete();
      } else {
        final now = DateTime.now().toString();

        await FirebaseFirestore.instance
            .collection("orders")
            .doc(now)
            .set(anMap);
        await FirebaseFirestore.instance
            .collection("cart")
            .doc(anEmail)
            .delete();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
