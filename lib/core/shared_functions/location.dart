import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class LocationManager
{

  static Future<LocationPermission> getPermission({
    required context,
  })async
  {
    bool services;
    LocationPermission permission;
    services = await Geolocator.isLocationServiceEnabled();
    if(services == false)
    {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Services',
        desc: 'Dialog description here.............',
        body: Text('Services not enabled'),
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied)
    {
      permission = await Geolocator.requestPermission();
    }
    print(permission.toString());
    return permission;
  }



  static Future<Position?> getCurrentLocation()async
  {
    return await Geolocator.getCurrentPosition();
  }


  static double getDistanceFromLatLonInM({
    required double lat1,
    required double lon1,
    required double lon2,
    required double lat2,
}) {

    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2-lat1);  // deg2rad below
    var dLon = deg2rad(lon2-lon1);
    var a =
        sin(dLat/2) * sin(dLat/2) +
            cos(deg2rad(lat1)) * cos(deg2rad(lat2)) *
                sin(dLon/2) * sin(dLon/2)
    ;
    var c = 2 * atan2(sqrt(a), sqrt(1-a));
    var d = R * c; // Distance in km
    return d*1000;
  }

  static deg2rad(deg) {
    return deg * (pi/180);
  }

}