import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const InteractiveViewerDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InteractiveViewerDemo extends StatefulWidget {
  const InteractiveViewerDemo({super.key});

  @override
  State<InteractiveViewerDemo> createState() => _InteractiveViewerDemoState();
}

class _InteractiveViewerDemoState extends State<InteractiveViewerDemo> {
  final TransformationController _transformationController =
      TransformationController();
  double _currentScale = 1.0;

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(() {
      setState(() {
        _currentScale = _transformationController.value.getMaxScaleOnAxis();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Image Zoom Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: () =>
                _transformationController.value = Matrix4.identity(),
          ),
        ],
      ),
      body: Center(
        // Centers the entire InteractiveViewer on screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Zoom: ${(_currentScale * 100).toStringAsFixed(0)}%'),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              height: 250,
              child: InteractiveViewer(
                transformationController:
                    _transformationController, // Connects the controller to track transformations
                panEnabled: true, // Keeps it in one position (no dragging)
                scaleEnabled: true, // Allows pinching
                minScale: 0.5,
                maxScale: 4.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/4.jpg',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
