

import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates{
  final String error ;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates{
  final String error ;

  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model ;

  ShopSuccessChangeFavoritesState(this.model);

}

class ShopErrorChangeFavoritesState extends ShopStates{
  final String error ;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates{
  final String error ;

  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginModel ;
  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{
  final String error ;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel ;
  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates{
  final String error ;

  ShopErrorUpdateUserState(this.error);
}
