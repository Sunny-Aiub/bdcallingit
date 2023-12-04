
import 'package:bdcallingit/app/utils/common_funcs.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermissions{

  static Future<bool> getCameraPermission() async{
    PermissionStatus permissionStatus = await Permission.camera.status;
    if(permissionStatus.isGranted == true){
      return true;
    }
    else if(permissionStatus.isDenied){
      PermissionStatus permissionStatus = await Permission.camera.request();
      if(permissionStatus.isGranted == true){
        return true;
      }else{
        CommonFunctions.showToast('Camera Permission is required', Colors.red);
        return false;
      }
    }

    else{
      return false;
    }
  }
}