// import 'package:cached_map/cached_map.dart';

// class CacheService {
//   static saveData(Map<String, dynamic> data, String fileName) async {
//     await Mapped.saveFileDirectly(file: data, cachedFileName: fileName);
//   }

//   static Future<Map<String, dynamic>> getData(String fileName) async {
//     Map<String, dynamic> cachedData =
//         await Mapped.loadFileDirectly(cachedFileName: fileName);
//     return cachedData;
//   }

//   static deleteData(String fileName) {
//     Mapped.deleteFileDirectly(cachedFileName: fileName);
//   }
// }
