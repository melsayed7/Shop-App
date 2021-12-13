



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/cache_helper.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'moduels/login/shop_login_screen.dart';
import 'moduels/onboarding/on_boarding_screen.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();


  //bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget ;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null)
  {
    if(token != null ) {
      widget = ShopLayout();
    }else {
      widget = ShopLoginScreen();
    }
  }else {
    widget =OnBoardingScreen() ;
  }

  runApp(MyApp(
      widget
  ));
}

class MyApp extends StatelessWidget {

  //final bool isDark ;
  final Widget startWidget ;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => ShopCubit()
          ..getHomeData()..getCategories()..getFavorites() ..getUserData() ,
        ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme ,
      //darkTheme: darkTheme ,
      //themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
      home: startWidget ,
    ),
    );
  }
}
