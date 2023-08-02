import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SearchController extends GetxController{
  final searchController =TextEditingController();
  String text='';
  List<QueryDocumentSnapshot<Object?>> searchList=[];
  search(String value){
    text=value;
    searchValue();
  }

  searchValue()async{
    if(text!=''){
      searchList=await FirebaseFirestore.instance
                  .collection('pocketBuy')
                  .doc('admin')
                  .collection('products')
                  .get().then((value) => value.docs.where((element) {
                    var name=element['productName'] as String;
                    var brand=element['productBrand'] as String;
                    if(name.toLowerCase().contains(text.toLowerCase().trim())){
                      return true;
                    }
                    return false;
                  }).toList());
    }else{
      searchList=[];
    }
    update();
  }

}