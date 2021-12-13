import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/moduels/login/cubit/cubit.dart';
import 'package:shop_app/moduels/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/cache_helper.dart';

import 'cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit ,ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {

                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
                token =state.loginModel.data!.token;
              });

            }else{
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFeild(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return('please enter your Name');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFeild(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return('please enter your email address');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFeild(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: (){
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return('password is too short');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFeild(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return('please enter your phone number');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState ,
                          builder:(context) => defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUppercase: true,
                          ),
                          fallback:(context) => Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
