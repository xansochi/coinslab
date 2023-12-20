import 'dart:convert';

import 'package:flutter/material.dart';
import '../api/Coinlist/getcoin_api.dart';

class CoinListProvider extends ChangeNotifier {
  // final _service = TodoService();
  List<dynamic> _coins=[];
  List _searchedCoins = [];
  List _original = [];
  late int _statusCode;

  bool isLoading = true;
  // @override
  // notifyListeners();
  dynamic _coinlist ;

  dynamic get getCoinList => _coinlist;
  dynamic get getCoins => _coins;
  dynamic get getSearchedCoins => _searchedCoins;
  dynamic get getOriginal => _original;
  dynamic get getStatusCode => _statusCode;

  void setSearchData(String query) {
    if (query.isEmpty) {
      _searchedCoins = _original;
      notifyListeners();
      return;
    }
    query = query.toLowerCase();
    List result = [];
    for (var p in _searchedCoins) {
      var name = p["name"].toString().toLowerCase();
      if (name.contains(query)) {
        result.add(p);
      }
    }
    _searchedCoins = result;
    notifyListeners();
  }

  //   void search(String query) {
  //   if (query.isEmpty) {
  //     searchedCoins = original;
  //     setState(() {});
  //     return;
  //   }
  //   query = query.toLowerCase();
  //   List result = [];
  //   for (var p in searchedCoins!) {
  //     var name = p["name"].toString().toLowerCase();
  //     if (name.contains(query)) {
  //       result.add(p);
  //     }
  //   }
  //   searchedCoins = result;
  //   setState(() {});
  // }

  Future getAllCoins() async {
    // isLoading = false;
    notifyListeners();
    fetchCoinsFromCoinGecko().then((data) {
    notifyListeners();
      if (data == 429) {
        print('429');
        print(data);
        print(isLoading);
        _statusCode = data;
      notifyListeners();
      }
      else {
      var result = jsonDecode(data);
      _coinlist = result;
      _searchedCoins = result;
      _coins = result;
      _original = result;
      isLoading = false;
      notifyListeners();
        print('CoinListProvider');
        print(data);
        print(isLoading);
      notifyListeners();
      }
    });
  }
}
