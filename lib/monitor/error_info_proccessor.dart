import 'package:device_info_plus/device_info_plus.dart';
import 'package:ume_kit_monitor/core.dart';

/// @date 2020/12/21
/// describe:
class ErrorInfoProcessor {
  static AndroidDeviceInfo? _androidInfo;
  static IosDeviceInfo? _iosInfo;
  static String? _errorHeader;
  static String? _errorSimpleHeader;

  static Future<String?> getDeviceInfo() async {
    if (!InnerUtils.isEmpty(_errorHeader)) {
      return _errorHeader;
    }
    DeviceInfoPlugin plugin = new DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      _androidInfo = _androidInfo ?? await plugin.androidInfo;
      _errorHeader = '''
      Model:${_androidInfo?.model}\n
      Manufacturer:${_androidInfo?.manufacturer}\n
      Brand:${_androidInfo?.brand}\n
      Version:${_androidInfo?.version.release}\n
      SdkInt:${_androidInfo?.version.sdkInt}\n
      Abis:${_androidInfo?.supportedAbis.join(',')}\n
      Product:${_androidInfo?.product}\n
      Fingerprint:${_androidInfo?.fingerprint}\n
      IsPhysicalDevice:${_androidInfo?.isPhysicalDevice}\n
      IsPhysicalDevice:${_androidInfo?.isPhysicalDevice}\n
      Id:${_androidInfo?.id}\n
      Hardware:${_androidInfo?.hardware}\n
      Display:${_androidInfo?.display}\n
      Board:${_androidInfo?.board}\n
      Bootloader:${_androidInfo?.bootloader}\n
      ''';
    } else {
      _iosInfo = _iosInfo ?? await plugin.iosInfo;
      _errorHeader = '''
      Name:${_iosInfo?.name}\n
      SystemName:${_iosInfo?.systemName}\n
      SystemVersion:${_iosInfo?.systemVersion}\n
      IdentifierForVendor:${_iosInfo?.identifierForVendor}\n
      IsPhysicalDevice:${_iosInfo?.isPhysicalDevice}\n
      ''';
    }
    return _errorHeader;
  }

  static String? getSimpleDeviceInfo() {
    if (!InnerUtils.isEmpty(_errorSimpleHeader)) {
      return _errorSimpleHeader;
    }
    if (_androidInfo != null || _iosInfo != null) {
      if (GetPlatform.isAndroid) {
        _errorSimpleHeader = '''
      Model:${_androidInfo?.model}\n
      Brand:${_androidInfo?.brand}\n
      SdkInt:${_androidInfo?.version.sdkInt}\n
      IsPhysicalDevice:${_androidInfo?.isPhysicalDevice}\n
      Id:${_androidInfo?.id}\n
      ''';
      } else {
        _errorSimpleHeader = '''
      Name:${_iosInfo?.name}\n
      SystemName:${_iosInfo?.systemName}\n
      SystemVersion:${_iosInfo?.systemVersion}\n
      IdentifierForVendor:${_iosInfo?.identifierForVendor}\n
      IsPhysicalDevice:${_iosInfo?.isPhysicalDevice}\n
      ''';
      }
    }
    return _errorSimpleHeader;
  }
}
