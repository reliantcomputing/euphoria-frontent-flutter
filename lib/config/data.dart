import 'dart:math';

Random random = Random();

bool isMeeting = random.nextBool();

List names = [
  "Ling Waldner",
  "Gricelda Barrera",
  "Lenard Milton",
  "Bryant Marley",
  "Rosalva Sadberry",
  "Guadalupe Ratledge",
  "Brandy Gazda",
  "Kurt Toms",
  "Rosario Gathright",
  "Kim Delph",
  "Stacy Christensen",
];

List messages = [
  "Hey, how are you doing?",
  "Are you available tomorrow?",
  "It's late. Go to bed!",
  "This cracked me up 😂😂",
  "MTC Rocks!!!",
  "The last rocket🚀",
  "Griezmann signed for Barca❤️❤️",
  "Will you be attending the meetup tomorrow?",
  "Are you angry at something?",
  "Work hard bro.",
  "Can i hear your voice?",
];

List otherNotifs = [
  "${names[random.nextInt(10)]} and ${random.nextInt(100)} others liked your post",
  "${names[random.nextInt(10)]} mentioned you in a comment",
  "${names[random.nextInt(10)]} shared your post",
  "${names[random.nextInt(10)]} commented on your post",
  "${names[random.nextInt(10)]} replied to your comment",
  "${names[random.nextInt(10)]} reacted to your comment",
  "${names[random.nextInt(10)]} asked you to join a Group️",
  "${names[random.nextInt(10)]} asked you to like a page",
  "You have memories with ${names[random.nextInt(10)]}",
  "${names[random.nextInt(10)]} Tagged you and ${random.nextInt(100)} others in a post",
  "${names[random.nextInt(10)]} Sent you a friend request",
];

List robotNotifs = [
  "Robot sent you a notification 1.",
  "Robot sent you a notification 2.",
  "Robot sent you a notification 3.",
  "Robot sent you a notification 4.",
  "Robot sent you a notification 5.",
  "Robot sent you a notification 6.",
  "Robot sent you a notification 7.",
  "Robot sent you a notification 8.",
  "Robot sent you a notification 9.",
  "Robot sent you a notification 10.",
  "Robot sent you a notification 11.",
  "Robot sent you a notification 12.",
];

List teamNotifs = [
  "Team sent you a notification 1.",
  "Team sent you a notification 2.",
  "Team sent you a notification 3.",
  "Team sent you a notification 4.",
  "Team sent you a notification 5.",
  "Team sent you a notification 6.",
  "Team sent you a notification 7.",
  "Team sent you a notification 8.",
  "Team sent you a notification 9.",
  "Team sent you a notification 10.",
  "Team sent you a notification 11.",
  "Team sent you a notification 12.",
];

List otherNotifications = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "time": "${random.nextInt(50)} min ago",
  "notif": otherNotifs[random.nextInt(10)],
  "viewed": random.nextBool()
});

List teamNotifications = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "time": "${random.nextInt(50)} min ago",
  "notif": teamNotifs[random.nextInt(10)],
  "viewed": random.nextBool()
});

List robotNotifications = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "time": "${random.nextInt(50)} min ago",
  "notif": robotNotifs[random.nextInt(10)],
  "viewed": random.nextBool()
});

List posts = List.generate(13, (index)=>{
    "name": names[random.nextInt(10)],
    "dp": "assets/cm${random.nextInt(10)}.jpeg",
    "time": "${random.nextInt(50)} min ago",
    "img": "assets/cm${random.nextInt(10)}.jpeg",
    "likes": random.nextInt(50),
    "comments": random.nextInt(50)
});

List chats = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "msg": messages[random.nextInt(10)],
  "counter": random.nextInt(20),
  "time": "${random.nextInt(50)} min ago",
  "isOnline": random.nextBool(),
});

List groups = List.generate(13, (index)=>{
  "name": "Group ${random.nextInt(20)}",
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "msg": messages[random.nextInt(10)],
  "counter": random.nextInt(20),
  "time": "${random.nextInt(50)} min ago",
  "isOnline": random.nextBool(),
});

List types = ["text", "image"];
List conversation = List.generate(10, (index)=>{
  "username": "Group ${random.nextInt(20)}",
  "time": "${random.nextInt(50)} min ago",
  "type": types[random.nextInt(2)],
  "replyText": messages[random.nextInt(10)],
  "isMe": random.nextBool(),
  "isGroup": false,
  "isReply": random.nextBool(),
});

List students = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "status": "MTC is a kak designer.",
  "isAccept": random.nextBool(),
  "time": "${random.nextInt(50)} min ago",
  "isOnline": random.nextBool()
});