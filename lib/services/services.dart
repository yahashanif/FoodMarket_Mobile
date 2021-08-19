import 'dart:convert';
import 'dart:io';

import 'package:foodmarket/models/models.dart';
import 'package:foodmarket/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

part 'user_Services.dart';
part 'food_services.dart';
part 'transaction_services.dart';

String baseURL = 'http://ikhwanulmuslimin.com/laravel_foodMarket/public/api/';
String URLPhoto =
    "http://ikhwanulmuslimin.com/laravel_foodMarket/storage/app/public/";
