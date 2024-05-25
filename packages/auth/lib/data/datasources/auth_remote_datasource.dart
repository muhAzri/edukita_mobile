import 'package:auth/data/models/auth_data_model.dart';
import 'package:auth/data/models/login_model.dart';
import 'package:core/common/exception.dart';
import 'package:core/common/response.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDatasource {
  Future<void> login();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio client;
  final FlutterSecureStorage storage;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDatasourceImpl({
    required this.client,
    required this.storage,
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<void> login() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw ServerException("Google Sign In Failed");

      final googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw ServerException("Google Sign In Failed: Access Token Null");
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw ServerException("Google Sign In Failed: User Null");
      }

      final accessToken = await userCredential.user!.getIdToken();

      await storage.write(key: "firebase_token", value: accessToken);

      final loginModel = LoginModel(
        name: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
        profilePicture: userCredential.user!.photoURL!,
      );

      final response =
          await client.post("/auth/sessions", data: loginModel.toJson());

      final responseModel = ResponseModel<AuthDataModel>.fromJson(response.data,
          (data) => AuthDataModel.fromJson(data as Map<String, dynamic>));

      if (response.statusCode != 200) {
        throw ServerException(responseModel.error!);
      }

      await storage.write(
          key: "access_token", value: responseModel.data?.accessToken);
      await storage.write(
          key: "refresh_token", value: responseModel.data?.refreshToken);
      await storage.delete(key: "firebase_token");
    } catch (e) {
      if (e is ServerException) {
        throw ServerException(e.message);
      }
      throw ServerException(e.toString());
    }
  }
}
