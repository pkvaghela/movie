import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_api/tmdb_api.dart';

class AuthController extends GetxController {

  RxBool isShow = false.obs;
  TextEditingController searchCtrl = TextEditingController();
  RxBool up = true.obs;
  updateSearch() {
    up.refresh();
  }
}
