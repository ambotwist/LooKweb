import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset('assets/videos/Comp_1.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      if (mounted) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0.0); // Mute the video
        return _controller.play().catchError((error) {
          print('Video autoplay failed with error: $error');
          if (error is PlatformException) {
            print('Error code: ${error.code}');
            print('Error message: ${error.message}');
          }
          return null;
        });
      }
    }).catchError((error) {
      print('Video initialization failed with error: $error');
      return null;
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error loading video: ${snapshot.error}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LooK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Navbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 0, 85),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LooK',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 64,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -3,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'HOW IT WORKS',
                        style: TextStyle(
                          fontFamily: 'Impact',
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'CONTACT',
                        style: TextStyle(
                          fontFamily: 'Impact',
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Existing content wrapped in Expanded
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    // Title and subtitle
                    Container(
                      color: Color.fromARGB(255, 255, 0, 85),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: Column(
                          children: [
                            Text(
                              'AI-POWERED FASHION',
                              style: TextStyle(
                                fontFamily: 'Impact',
                                fontSize: 48,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Pitch section
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          Text(
                            'Discover Your Perfect Style',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Swipe your way to a personalized wardrobe. Our AI learns your unique style preferences in real-time, delivering fashion recommendations that feel like they were handpicked just for you.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                          // const SizedBox(height: 30),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Icon(Icons.swipe,
                          //         size: 24, color: Color.fromARGB(255, 255, 0, 85)),
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       'Swipe',
                          //       style: TextStyle(
                          //         fontFamily: 'Montserrat',
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //     const SizedBox(width: 24),
                          //     Icon(Icons.auto_awesome,
                          //         size: 24, color: Color.fromARGB(255, 255, 0, 85)),
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       'Find',
                          //       style: TextStyle(
                          //         fontFamily: 'Montserrat',
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //     const SizedBox(width: 24),
                          //     Icon(Icons.shopping_bag,
                          //         size: 24, color: Color.fromARGB(255, 255, 0, 85)),
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       'Buy',
                          //       style: TextStyle(
                          //         fontFamily: 'Montserrat',
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),

                    // const SizedBox(height: 40),
                    // Video section (replacing screenshots)
                    const VideoPlayerScreen(),

                    // const SizedBox(height: 40),

                    // Footer section
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Developer: ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'AmboTwist',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 24),
                              Text(
                                'GitHub: ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                        'https://github.com/ambotwist');
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }
                                  },
                                  child: Text(
                                    '@ambotwist',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 255, 0, 85),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Text(
                                'Email: ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    final Uri emailLaunchUri = Uri(
                                      scheme: 'mailto',
                                      path: 'ambotwist@gmail.com',
                                    );
                                    if (await canLaunchUrl(emailLaunchUri)) {
                                      await launchUrl(emailLaunchUri);
                                    }
                                  },
                                  child: Text(
                                    'ambotwist@gmail.com',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 255, 0, 85),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '© ${DateTime.now().year} LooK. All rights reserved.',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
