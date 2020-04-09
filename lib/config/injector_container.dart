
import 'package:euphoriafx/services/auth_service.dart';
import 'package:euphoriafx/services/other_notification_service.dart';
import 'package:euphoriafx/services/post_service.dart';
import 'package:euphoriafx/services/robot_notification_service.dart';
import 'package:euphoriafx/services/single_chat_service.dart';
import 'package:euphoriafx/services/stream_service.dart';
import 'package:euphoriafx/services/team_notification_service.dart';
import 'package:euphoriafx/services/user_api_service.dart';
import 'package:get_it/get_it.dart';

final s1 = GetIt.instance;

void init(){
  s1.registerFactory(()=>PostService());
  s1.registerFactory(()=>RobotNotificationService());
  s1.registerFactory(()=>OtherNotificationService());
  s1.registerFactory(()=>TeamNotificationService());
  s1.registerFactory(()=>UserApiService());
  s1.registerFactory(()=>StreamService());
  s1.registerFactory(()=>AuthService());
  s1.registerFactory(()=>SingleChatService());
}