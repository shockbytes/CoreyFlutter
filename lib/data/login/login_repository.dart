


import 'package:Corey/model/corey_user.dart';

abstract class LoginRepository {

  Future<CoreyUser> signIn();

}