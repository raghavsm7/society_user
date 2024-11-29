import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static final StorageUtils _storageUtils = StorageUtils();

  static StorageUtils get storageUtilsInstance => _storageUtils;

  final GetStorage _getStorage = GetStorage();
  final GetStorage _getStoragePermanently = GetStorage("PermanentStorage");

  // save to storage
  saveToStorage({required String key, required dynamic value}) {
    _getStorage.write(key, value);
  }

  // save to permanent storage
  saveToPermanentStorage({required String key, required dynamic value}) {
    _getStoragePermanently.write(key, value);
  }

  // get data from storage
  dynamic getFromStorage({required String key}) {
    return _getStorage.read(key);
  }

  // get data from storage
  dynamic getFromPermanentStorage({required String key}) {
    return _getStoragePermanently.read(key);
  }

  dynamic decodeData({required data}) {
    return jsonDecode(data);
  }

  // clear normal storage
  clearStorage() {
    _getStorage.erase();
  }

  // clear permanent storage
  clearPermanentStorage() {
    _getStoragePermanently.erase();
  }
}
