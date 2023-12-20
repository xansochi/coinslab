class DashboardCoins{
    List nums;
    List<dynamic> modifyCoinList() {
     List dataresult =[];
     double totalresult = 0;
      for (var element in nums) {
        final newnums = <String,String>{...element};
        totalresult = totalresult + double.parse(newnums['summ']!);
        // newnums['totalsumm'] = totalresult.toString();
        }
        dataresult.add({'totalsumm':totalresult});
        print('modifyCoinList');
        print(dataresult);
    return dataresult;
    }
    DashboardCoins(this.nums);
    void display() => print("Original: $nums ");
}