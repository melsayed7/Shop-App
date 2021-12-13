
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/moduels/cateogries/cateogries_screen.dart';
import 'package:shop_app/moduels/favourites/favourites_screen.dart';
import 'package:shop_app/moduels/products/products_screen.dart';
import 'package:shop_app/moduels/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/cache_helper.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';


class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ] ;

  void changeBottom (index)
  {
    currentIndex = index ;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel ;
  void getHomeData ()
  {

    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token ,
    ).then((value) {

      homeModel = HomeModel.fromJson(value.data);
      print('Shop Success show data product ');
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites ,
        });
      });
      emit(ShopSuccessHomeDataState());

    }).catchError((error){
      print('error in shop home product ');
      emit(ShopErrorHomeDataState(error.toString()));
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel ;
  void getCategories ()
  {

    DioHelper.getData(
      url: GET_CATEGORIES,
      //token: token ,
    ).then((value) {

      categoriesModel = CategoriesModel.fromJson(value.data);
      print('Shop Success show data in categories');
      emit(ShopSuccessCategoriesState());

    }).catchError((error){
      print('error in categories ');
      emit(ShopErrorCategoriesState(error.toString()));
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel ;
  Map<int,bool> favorites = {};
  void changeFavorites ( int productID)
  {
    favorites[productID] = !(favorites[productID]??false);
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      token: CacheHelper.getData(key:'token') ,
      data: {
        'product_id' : productID ,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if(!changeFavoritesModel!.status)
      {
        favorites[productID] =  !(favorites[productID]??false);
      }else{
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){

      favorites[productID] =  !(favorites[productID]??false);
      emit(ShopErrorChangeFavoritesState(error.toString()));
      print(error.toString());
    });
  }

  FavoritesModel? favoritesModel ;
  void getFavorites ()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: CacheHelper.getData(key:'token') ,
    ).then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);
      print('Shop Success show data in getFavorites');
      emit(ShopSuccessGetFavoritesState());


    }).catchError((error){
      print('error in getFavorites ');
      emit(ShopErrorGetFavoritesState(error.toString()));
      print(error.toString());
    });
  }

  ShopLoginModel? userModel ;
  void getUserData ()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token
    ).then((value) {

      userModel = ShopLoginModel.fromJson(value.data);
      print('Shop Success show data in UserData');
      print(userModel!.data!.name.toString());
      print(userModel!.data!.phone.toString());
      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((error){
      emit(ShopErrorUserDataState(error.toString()));
      print(error.toString());
    });
  }

  void updateUserData ({
    required String name ,
    required String email ,
    required String phone ,
})
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token ,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {

      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));

    }).catchError((error){
      emit(ShopErrorUpdateUserState(error.toString()));
      print(error.toString());
    });
  }
}