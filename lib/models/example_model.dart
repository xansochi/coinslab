// class CoinFromApi {
//   final String id;
//   final String name;
//   final double price;
//   final String symbol;
//   final String price24;
//   final String image;
 
//   CoinFromApi({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.symbol,
//     required this.price24,
//     required this.image,
//   });
 
//   factory CoinFromApi.fromJson(json) {
//     return CoinFromApi(
//       id: json['id'],
//       name: json['name'],
//       price: json['market_data']['current_price']['usd'],
//       symbol: json['symbol'],
//       price24: json['price_change_percentage_24h'],
//       image: json['image']['small'],
//     );
//   }
// }