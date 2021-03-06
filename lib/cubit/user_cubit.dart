import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodmarket/cubit/cubit.dart';
import 'package:foodmarket/models/models.dart';
import 'package:foodmarket/services/services.dart';
import 'package:foodmarket/ui/pages/pages.dart';
import 'package:get/get.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserServices.signIn(email, password);

    if (result.value != null) {
      emit(UserLoaded(result.value!));
    } else {
      emit(UserLoadingFailed(result.message!));
    }
  }

  Future<void> signUp(User user, String password, {File? pictureFile}) async {
    ApiReturnValue<User> result =
        await UserServices.signUp(user, password, pictureFile: pictureFile);

    if (result.value != null) {
      emit(UserLoaded(result.value!));
    } else {
      emit(UserLoadingFailed(result.message!));
    }
  }

  Future<void> uploadProfilePicture(File pictureFile) async {
    ApiReturnValue<String> result =
        await UserServices.uploadProfilePicture(pictureFile);

    if (result.value != null) {
      emit(UserLoaded((state as UserLoaded).user.copyWith(
          picturePath:
              "http://ikhwanulmuslimin.com/laravel_foodMarket/storage/app/public/" +
                  result.value.toString())));
    }
  }

  Future<void> logout() async {
    ApiReturnValue<bool> result = await UserServices.logOut();
    if (result != false) {
      emit(UserInitial());
    } else {
      emit(UserLoadingFailed("asdasd"));
    }
  }
}
