// ignore_for_file: constant_identifier_names

class ConstantsForApi {
  static const String getCoinsFromCoinGeckoURL = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false&locale=en';
  static const String loginApiURL =  'node-auth-api-two.vercel.app';
  static const String UpdateCoinsApiURL =  'https://node-auth-api-two.vercel.app/api/auth/';
  static const String urlStringForUpdatePrice = 'https://api.coingecko.com/api/v3/simple/price?ids=ethereum%2C';
  static const String newsApiURL = 'https://cryptopanic.com/api/v1/posts/?auth_token=a996b61a42aa24fb425ffedd96927a5e4037ed93&public=true&&regions=ru';
  static const String getCoinDataUrl = 'https://api.coingecko.com/api/v3/coins/ethereum?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false';


  
}