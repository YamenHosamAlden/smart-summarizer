import 'package:flutter/material.dart';
import 'package:smartsummarizer/Services/Helper/api_result.dart';

class ApiChecker {
  static void checkApi(BuildContext context, ApiResult apiResult) {
    if (apiResult.error is! String && apiResult.error == 'Unauthorized.') {
      //do somthing before navigator to other page
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => <page after checking repo>), (route) => false);
    } else {
      String errorMessage;
      if (apiResult.error is String) {
        errorMessage = apiResult.error.toString();
      } else {
        errorMessage = apiResult.error['message'];
      }
      debugPrint(errorMessage);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errorMessage, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
    }
  }
}
