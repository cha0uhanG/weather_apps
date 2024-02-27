import 'package:get_storage/get_storage.dart';


class MyPref {
  static final MyPref _myPref = MyPref._internal();

  factory MyPref() {
    return _myPref;
  }

  MyPref._internal();


  final  temp = 0.0.val("temp");
  final stateName = ''.val("stateName");
  final humidity = 0.val('humidity');



  void removeData() {
    temp.val = 0.0;
    stateName.val = '';
    humidity.val = 0;
  }
}