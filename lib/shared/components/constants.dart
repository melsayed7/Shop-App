

// api link
// base https://newsapi.org/
// method v2/top-headlines?
// query country=us&category=business&apiKey=API_KEY

// search
//https://newsapi.org/v2/everything?q=tesla&apiKey=2e8b89193da249e5a3d8e9c11cf911ae


import 'package:shop_app/moduels/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/cache_helper.dart';
import 'components.dart';

void signOut (context)
{
  CacheHelper.removeData(key:'token', ).then((value) {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String? token ='';

