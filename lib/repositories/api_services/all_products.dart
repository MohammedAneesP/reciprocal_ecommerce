import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:reciprocal_task/domain/models/product_model.dart';

class AllProducts {
  Future<List<Products>> fetchAllProducts() async {
    try {
      final value = Uri.parse("https://fakestoreapi.com/products");

      final anResponce = await http.get(value);
      if (anResponce.statusCode == HttpStatus.ok) {
        List<Products> theProducts = [];
        final anData = jsonDecode(anResponce.body);

        for (var element in anData) {
          theProducts.add(Products.fromJson(element));
        }

        return theProducts;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
