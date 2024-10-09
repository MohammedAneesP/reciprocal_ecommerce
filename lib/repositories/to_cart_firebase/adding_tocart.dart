import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reciprocal_task/domain/models/product_model.dart';

class AddingTocart {
  Future<void> addTocart(
      {required Products product,
      required String anEmail,
      required String productId}) async {
    final toMap = product.toJson();

    try {
      final anValue = await FirebaseFirestore.instance
          .collection("cart")
          .doc(anEmail)
          .get();
          
      if (anValue.exists) {
        final datas = anValue.data();

        if (datas!.isEmpty) {
          await FirebaseFirestore.instance
              .collection("cart")
              .doc(anEmail)
              .set({productId: toMap});

        } else {
          Map<String, dynamic> forCart = {};
          forCart.addAll(datas);
          forCart.addAll({productId: toMap});

          await FirebaseFirestore.instance
              .collection("cart")
              .doc(anEmail)
              .set(forCart); // if cart already, fetch the existing value and adding the new value with it
        }
      } else {
        await FirebaseFirestore.instance
            .collection("cart")
            .doc(anEmail)
            .set({productId: toMap}); //if no cart section exists in database adding cart as new collection
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
