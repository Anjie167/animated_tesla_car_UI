import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{

  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetLock = true;
  bool isTrunkLock = true;

  int selectedBottomTab = 0;

  void onBottomNavigationTabChange(int index){
    selectedBottomTab = index;
    notifyListeners();
  }

  void updateRightDoorLock(){
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock(){
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateBonnetLock(){
    isBonnetLock = !isBonnetLock;
    notifyListeners();
  }

  void updateTrunkLock(){
    isTrunkLock = !isTrunkLock;
    notifyListeners();

  }


  bool isCoolSelected = true;

  void updateCoolSelectedTab(){
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  bool isShowTyres = false;

  void showTyreController(int index){
    if(selectedBottomTab !=3 && index == 3){
      Future.delayed(Duration(milliseconds: 480), () {
        isShowTyres = true;
        notifyListeners();
      }
      );
    }else{
      isShowTyres = false;
      notifyListeners();
    }
  }

  bool isShowTyreStatus = false;
  void tyreStatusController(int index){
    if(selectedBottomTab != 3 && index == 3){
      isShowTyreStatus = true;
      notifyListeners();
    }else{
      Future.delayed(Duration(milliseconds: 400), (){
        isShowTyreStatus = false;
        notifyListeners();
      });
          }
  }
}