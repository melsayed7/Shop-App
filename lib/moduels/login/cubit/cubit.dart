
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/moduels/login/cubit/states.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel ;

  void userLogin ({
    required String email ,
    required String password ,
})
  {
    emit(ShopLoginLoadingState());
    print('before dio helper login ');
    DioHelper.postData(
      url: LOGIN ,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;
  void changePasswordVisibility()
  {
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopChangePasswordVisibilityState());
  }

}