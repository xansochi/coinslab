class AppData {
  static final AppData _appData = AppData._internal();
  double income = 0.0;
  double summ = 0.0;

  factory AppData() {
    return _appData;
  }
  incomePercent(){
     var percentIncome = ((income/summ)*100);
     return percentIncome;
  }
  AppData._internal();
}
final appData = AppData();

