import 'package:permission_handler/permission_handler.dart';

///* checks and requests(if said) for microphone, and external storage read write permissions
Future<bool> checkMicrophoneAndExtStoragePermissions({bool requestIfNoteGranted = false}) async {
  bool isMicPermissionGranted = false, isStoragePermissionGranted = false;
  isMicPermissionGranted = await checkMicrophonePermission(requestIfNoteGranted: requestIfNoteGranted);
  isStoragePermissionGranted = await checkExtStoragePermission(requestIfNoteGranted: requestIfNoteGranted);  
  return isMicPermissionGranted && isStoragePermissionGranted;
}

///* checks external storage read and write permission
Future<bool> checkExtStoragePermission({bool requestIfNoteGranted = false}) async {
  bool isAllOk = (await PermissionHandler().checkPermissionStatus(PermissionGroup.storage))==PermissionStatus.granted?true:false;
  if(isAllOk) return Future.value(true);
  else if(requestIfNoteGranted) return Future.value(await requestExtStoragePermission());
  else return Future.value(false);
}

///* requests for external storage read and write permission
Future<bool> requestExtStoragePermission() async {
  bool isAllOk = true;  
  var permissionStatus = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  if(permissionStatus[PermissionGroup.storage] != PermissionStatus.granted) isAllOk = false;
  return Future.value(isAllOk);
}

///* requests for microphone permission
Future<bool> requestMicrophonePermissions() async {
  bool isAllOk = true;
  var permissionStatus = await PermissionHandler().requestPermissions([PermissionGroup.microphone]);
  if(permissionStatus[PermissionGroup.microphone] != PermissionStatus.granted) isAllOk = false;
  return Future.value(isAllOk);
}

///* checks microphone permission
Future<bool> checkMicrophonePermission({bool requestIfNoteGranted = false}) async {
  bool isAllOk = (await PermissionHandler().checkPermissionStatus(PermissionGroup.microphone))==PermissionStatus.granted?true:false;
  if(isAllOk) return Future.value(true);
  else if(requestIfNoteGranted) return Future.value(await requestMicrophonePermissions());
  else return Future.value(false);
}
