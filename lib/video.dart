// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(const VideoApp());

// class VideoApp extends StatefulWidget {
//   const VideoApp({Key? key}) : super(key: key);

//   @override
//   _VideoAppState createState() => _VideoAppState();
// }

// class _VideoAppState extends State<VideoApp> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset(
//         'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');

//     _controller.addListener(() {
//       setState(() {});
//     });
//     _controller.setLooping(true);
//     _controller.initialize().then((_) => setState(() {}));
//     _controller.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             SizedBox.expand(
//               child: FittedBox(
//                 fit: BoxFit.cover,
//                 child: SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: VideoPlayer(_controller),
//                 ),
//               ),
//             ),
//             const LoginWidget()
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }

// class LoginWidget extends StatelessWidget {
//   const LoginWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.all(16),
//           width: 300,
//           height: 250,
//           color: Colors.white.withAlpha(400),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               const TextField(
//                 decoration: InputDecoration(
//                     hintText: 'Username',
//                     hintStyle: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                   hintStyle: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     child: const Text('Sign-In'),
//                     onPressed: () {},
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   ElevatedButton(
//                     child: const Text('Sign-Up'),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // video_player: ^2.3.0