import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

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
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.15,
        minWidth: 200,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(
              minWidth: 200,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SizedBox(
                height: getResponsiveTextSize(context, 80),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: TypewriterText(
                    text: _words[_currentIndex],
                    style: TextStyle(
                      fontFamily: 'Monument',
                      fontSize: getResponsiveTextSize(context, 72),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.0,
                      height: 1.0,
                    ),
                    onComplete:
                        _isUnwriting ? _onUnwriteComplete : _onTypeComplete,
                    isUnwriting: _isUnwriting,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: getResponsivePadding(context, 4)),
          Container(
            constraints: BoxConstraints(
              minWidth: 200,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SizedBox(
                height: getResponsiveTextSize(context, 80),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: Text(
                    'FASHION',
                    style: TextStyle(
                      fontFamily: 'Monument',
                      fontSize: getResponsiveTextSize(context, 72),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.0,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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

double getResponsiveTextSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  double scaleFactor;
  if (screenWidth > 1600) {
    scaleFactor = 1.2;
  } else if (screenWidth > 1200) {
    scaleFactor = 1.0;
  } else if (screenWidth > 800) {
    scaleFactor = 0.8;
  } else {
    scaleFactor = 0.6;
  }

  // Apply maximum sizes for different text categories
  double size = baseSize * scaleFactor;
  if (baseSize >= 70) {
    // For large headings (like 72px)
    return min(size, 85);
  } else if (baseSize >= 40) {
    // For medium text (like 48px, 42px)
    return min(size, 42);
  } else {
    // For smaller text (like 28px and below)
    return min(size, 32);
  }
}

double getResponsivePadding(BuildContext context, double basePadding) {
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 1600) {
    return basePadding * 1.5;
  } else if (screenWidth > 1200) {
    return basePadding;
  } else if (screenWidth > 800) {
    return basePadding * 0.7;
  } else {
    return basePadding * 0.5;
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Navbar
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsivePadding(context, 40),
              vertical: getResponsivePadding(context, 0),
            ),
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
                    fontSize: getResponsiveTextSize(context, 72),
                    fontWeight: FontWeight.w700,
                    letterSpacing: -4,
                    color: Colors.white,
                  ),
                ),
                if (!isMobile)
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'About',
                          style: TextStyle(
                            fontFamily: 'Museum',
                            fontSize: getResponsiveTextSize(context, 20),
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                      SizedBox(width: getResponsivePadding(context, 20)),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Contact',
                          style: TextStyle(
                            fontFamily: 'Museum',
                            fontWeight: FontWeight.w200,
                            fontSize: getResponsiveTextSize(context, 20),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

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
                        padding: EdgeInsets.only(
                          top: getResponsivePadding(context, 10),
                          bottom: getResponsivePadding(context, 20),
                        ),
                        child: const AnimatedTitle(),
                      ),
                    ),

                    SizedBox(height: getResponsivePadding(context, 40)),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getResponsivePadding(context, 100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: getResponsivePadding(context, 20)),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Ofelia',
                                fontWeight: FontWeight.w200,
                                fontSize: getResponsiveTextSize(context, 42),
                                height: 1.5,
                                color: Colors.black87,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "Dressed for Every Moment: Whether it's a romantic date, a beach day, or a business meeting, let ",
                                ),
                                TextSpan(
                                  text: 'LooK',
                                  style: TextStyle(
                                    fontFamily: 'OfeliaText',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize:
                                        getResponsiveTextSize(context, 42),
                                    letterSpacing: -4,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' curate the perfect outfit for any occasion—so you always look your best.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Pitch section
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 1000,
                      ),
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: isMobile ? Axis.vertical : Axis.horizontal,
                        children: [
                          Expanded(
                            flex: isMobile ? 0 : 1,
                            child: Container(
                              padding: EdgeInsets.only(
                                left: getResponsivePadding(context, 40),
                                right: getResponsivePadding(
                                    context, isMobile ? 40 : 20),
                                top: getResponsivePadding(context, 50),
                                bottom: getResponsivePadding(context, 50),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Museum',
                                        fontWeight: FontWeight.w200,
                                        fontSize:
                                            getResponsiveTextSize(context, 48),
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
                                            fontSize: getResponsiveTextSize(
                                                context, 48),
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
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: isMobile
                                  ? MediaQuery.of(context).size.height * 0.4
                                  : MediaQuery.of(context).size.height * 0.7,
                              maxWidth: isMobile
                                  ? MediaQuery.of(context).size.width * 0.9
                                  : 400,
                            ),
                            padding: EdgeInsets.only(
                              left: getResponsivePadding(
                                  context, isMobile ? 20 : 40),
                              right: getResponsivePadding(
                                  context, isMobile ? 20 : 20),
                              top: getResponsivePadding(
                                  context, isMobile ? 20 : 40),
                              bottom: getResponsivePadding(
                                  context, isMobile ? 20 : 40),
                            ),
                            child: const VideoPlayerScreen(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),

                    // Occasion section
                    Flex(
                      mainAxisAlignment: MainAxisAlignment.center,
                      direction: isMobile ? Axis.vertical : Axis.horizontal,
                      children: [
                        Expanded(
                          flex: isMobile ? 0 : 1,
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: isMobile
                                  ? MediaQuery.of(context).size.height * 0.4
                                  : MediaQuery.of(context).size.height * 0.6,
                              maxWidth: isMobile
                                  ? MediaQuery.of(context).size.width * 0.9
                                  : 400,
                            ),
                            padding: EdgeInsets.only(
                              left: getResponsivePadding(
                                  context, isMobile ? 20 : 40),
                              right: getResponsivePadding(
                                  context, isMobile ? 20 : 10),
                              top: getResponsivePadding(
                                  context, isMobile ? 20 : 40),
                              bottom: getResponsivePadding(
                                  context, isMobile ? 20 : 40),
                            ),
                            child: Image.asset(
                              'assets/images/occasion_framed.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: getResponsivePadding(context, 40)),
                        Expanded(
                          flex: isMobile ? 0 : 1,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: getResponsivePadding(context, 10),
                              right: getResponsivePadding(context, 40),
                              top: getResponsivePadding(context, 50),
                              bottom: getResponsivePadding(context, 50),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: getResponsivePadding(context, 20)),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Museum',
                                      fontWeight: FontWeight.w200,
                                      fontSize:
                                          getResponsiveTextSize(context, 42),
                                      height: 1.5,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "Dressed for Every Moment: Whether it's a romantic date, a beach day, or a business meeting, let ",
                                      ),
                                      TextSpan(
                                        text: 'LooK',
                                        style: TextStyle(
                                          fontFamily: 'OfeliaText',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: getResponsiveTextSize(
                                              context, 42),
                                          letterSpacing: -4,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' curate the perfect outfit for any occasion—so you always look your best.',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
