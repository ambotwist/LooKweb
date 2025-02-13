import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final VoidCallback onComplete;
  final bool isUnwriting;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    required this.onComplete,
    required this.isUnwriting,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _displayText = '';
  int _charIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _controller.addListener(_onTick);
    if (widget.isUnwriting) {
      _charIndex = widget.text.length;
      _displayText = widget.text;
      _removeNextChar();
    } else {
      _addNextChar();
    }
  }

  void _onTick() {
    if (_controller.status == AnimationStatus.completed) {
      if (widget.isUnwriting) {
        if (_charIndex > 0) {
          _removeNextChar();
        } else {
          widget.onComplete();
        }
      } else {
        if (_charIndex < widget.text.length) {
          _addNextChar();
        } else {
          widget.onComplete();
        }
      }
    }
  }

  void _addNextChar() {
    _controller.forward(from: 0.0);
    setState(() {
      _displayText = widget.text.substring(0, _charIndex + 1);
      _charIndex++;
    });
  }

  void _removeNextChar() {
    _controller.forward(from: 0.0);
    setState(() {
      _charIndex--;
      _displayText = widget.text.substring(0, _charIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.isUnwriting != widget.isUnwriting) {
      if (widget.isUnwriting) {
        _charIndex = widget.text.length;
        _displayText = widget.text;
        _removeNextChar();
      } else {
        _displayText = '';
        _charIndex = 0;
        _addNextChar();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.style,
    );
  }
}

class AnimatedTitle extends StatefulWidget {
  const AnimatedTitle({super.key});

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle> {
  final List<String> _words = [
    'CURATED',
    'UNIQUE',
    'SIMPLIFIED',
  ];
  int _currentIndex = 0;
  Timer? _timer;
  bool _isUnwriting = false;

  @override
  void initState() {
    super.initState();
  }

  void _startNextWord() {
    if (mounted) {
      setState(() {
        _isUnwriting = false;
        _currentIndex = (_currentIndex + 1) % _words.length;
      });
    }
  }

  void _onTypeComplete() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isUnwriting = true;
        });
      }
    });
  }

  void _onUnwriteComplete() {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 100), _startNextWord);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100, // Fixed height to prevent layout shifts
          child: TypewriterText(
            text: _words[_currentIndex],
            style: const TextStyle(
              fontFamily: 'Monument',
              fontSize: 82,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
            onComplete: _isUnwriting ? _onUnwriteComplete : _onTypeComplete,
            isUnwriting: _isUnwriting,
          ),
        ),
        const Text(
          'FASHION',
          style: TextStyle(
            fontFamily: 'Monument',
            fontSize: 82,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
      ],
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
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LooK',
                  style: TextStyle(
                    fontFamily: 'OfeliaText',
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -4,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'About',
                        style: TextStyle(
                          fontFamily: 'Museum',
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Contact',
                        style: TextStyle(
                          fontFamily: 'Museum',
                          fontWeight: FontWeight.w300,
                          fontSize: 28,
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
                      color: Colors.black,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: const AnimatedTitle(),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Pitch section
                    Flex(
                      mainAxisAlignment: MainAxisAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Museum',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 48,
                                      height: 1.5,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Swipe your way to a personalized wardrobe. ',
                                      ),
                                      TextSpan(
                                        text: 'LooK',
                                        style: TextStyle(
                                          fontFamily: 'OfeliaText',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 48,
                                          letterSpacing: -4,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' learns your unique style preferences in real-time, delivering fashion recommendations that feel like they were handpicked just for you.',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              constraints: const BoxConstraints(
                                maxHeight: 600,
                              ),
                              child: const VideoPlayerScreen()),
                        ),
                      ],
                    ),

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
                                  fontFamily: 'NeueCorpNormal',
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'AmboTwist',
                                style: TextStyle(
                                  fontFamily: 'NeueCorpNormal',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 24),
                              Text(
                                'GitHub: ',
                                style: TextStyle(
                                  fontFamily: 'NeueCorpNormal',
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
                                      fontFamily: 'NeueCorpNormal',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
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
                                  fontFamily: 'NeueCorpNormal',
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
                                      fontFamily: 'NeueCorpNormal',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
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
                              fontFamily: 'NeueCorpNormal',
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
