import 'package:canteen_app/data/model/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource{

  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponseModel.toJson());
  }

  Future<void> removeAuthData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<AuthResponseModel> getAuthData() async{
    final prefs = await SharedPreferences.getInstance();
    final authDataUser = prefs.getString('auth_data');
    return AuthResponseModel.fromJson(authDataUser!);
  }

  Future<bool> isAuthData() async{
    final prefs = await SharedPreferences.getInstance();
    final authDataUser = prefs.getString('auth_data');
    return authDataUser != null;
  }
}