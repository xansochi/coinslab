const Map mockCurrentPrice = {
  "binancecoin": {
    "usd": 251.44
  },
  "dogecoin": {
    "usd": 0.074057
  },
  "eos": {
    "usd": 0.702723
  },
  "ethereum": {
    "usd": 2091.82
  },
  "cardano": {
    "usd": 0.3574
  },
    "ApiCoin": {
    "usd": 0.3574
  }
};
String basicUrl = 'https://api.coingecko.com/api/v3/simple/price?ids=the-open-network%2Ceos%2Csolana%2Cdogecoin%2Cdogecoin&vs_currencies=usd';


class Coins{
    List nums;
    List<dynamic> modifyCoinList() {
     List dataresult =[];
      for (var element in nums) {
        final newnums = <String,String>{...element};
        // newnums['income'] = (((double.parse(newnums['price']!)+123) * double.parse(newnums['quanity']!))).floor().toString() ;
        newnums['income'] = "0" ;
        // if (element['idcoin']=='dogecoin') {newnums['currentprice'] = mockCurrentPrice["dogecoin"]["usd"].toString();}
        // if (element['idcoin']=='binancecoin') {newnums['currentprice'] = mockCurrentPrice["binancecoin"]["usd"].toString();}
        // if (element['idcoin']=='eos') {newnums['currentprice'] = mockCurrentPrice["eos"]["usd"].toString();}
        // if (element['idcoin']=='ethereum') {newnums['currentprice'] = mockCurrentPrice["ethereum"]["usd"].toString();}
        // if (element['idcoin']=='cardano') {newnums['currentprice'] = mockCurrentPrice["cardano"]["usd"].toString();}
        // if (element['idcoin']=='ApiCoin') {newnums['currentprice'] = mockCurrentPrice["ApiCoin"]["usd"].toString();}
        dataresult.add(newnums);
        }
    return dataresult;
    }
    Coins(this.nums);
    void display() => print("Original: $nums ");
}