import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sudanet_app/features/auth/login/data/models/login_response.dart';
import 'package:sudanet_app/features/auth/login/domain/entities/login_entity.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _userKeyToken = 'USER_KEY_TOKEN';
  static const _userMacId = 'USER_SECRET_MAC_ID';

  static Future setUser({required UserEntity data}) async {
    await _storage.write(key: _userKeyToken, value: jsonEncode(data.toJson()));
  }

  static Future<UserData?> getUser() async {
    try {
      var res = await _storage.read(key: _userKeyToken);
      print('SecureStorage: ==>$res');
      // print('SecureStorage: ==>${jsonDecode(res!)['name']}');
      var user = UserData.fromJson(jsonDecode(res!));

      setMacId(macID: user.guid!);
      return user;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  static removeUser() async => await _storage.delete(key: _userKeyToken);

  static Future setMacId({required String macID}) async {
    await _storage.write(key: _userMacId, value: macID);
  }

  static Future<String?> getMacId() async {
    await _storage.read(key: _userMacId);
  }
}
