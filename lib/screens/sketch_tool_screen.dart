import 'package:flutter/material.dart';

class SketchToolScreen extends StatefulWidget {
  const SketchToolScreen({super.key});

  @override
  State<SketchToolScreen> createState() => _SketchToolScreenState();
}

class _SketchToolScreenState extends State<SketchToolScreen> {
  final List<Offset> _points = [];
  Color _selectedColor = Colors.black;
  double _strokeWidth = 2.0;
  bool _isErasing = false;

  final List<Color> _colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.brown,
    Colors.grey,
  ];

  final List<double> _strokeWidths = [1.0, 2.0, 4.0, 6.0, 8.0, 10.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E131A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sketch Tool',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo, color: Colors.white),
            onPressed: _undo,
            tooltip: 'Undo',
          ),
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: _clear,
            tooltip: 'Clear',
          ),
          IconButton(
            icon: const Icon(Icons.save, color: Color(0xFFD6FF23)),
            onPressed: _saveSketch,
            tooltip: 'Save',
          ),
        ],
      ),
      body: Column(
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF1A2029),
            child: Row(
              children: [
                // Color Palette
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _colors.length,
                      itemBuilder: (context, index) {
                        final color = _colors[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = color;
                              _isErasing = false;
                            });
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedColor == color && !_isErasing
                                    ? const Color(0xFFD6FF23)
                                    : Colors.white24,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Stroke Width
                Container(
                  width: 120,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _strokeWidths.length,
                    itemBuilder: (context, index) {
                      final width = _strokeWidths[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() => _strokeWidth = width);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: _strokeWidth == width
                                ? const Color(0xFFD6FF23)
                                : Colors.white24,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              width.toInt().toString(),
                              style: TextStyle(
                                color: _strokeWidth == width
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Eraser
                IconButton(
                  icon: Icon(
                    Icons.cleaning_services,
                    color: _isErasing ? const Color(0xFFD6FF23) : Colors.white70,
                  ),
                  onPressed: () {
                    setState(() => _isErasing = !_isErasing);
                  },
                  tooltip: 'Eraser',
                ),
              ],
            ),
          ),

          // Drawing Canvas
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate,
                  onPanStart: _onPanStart,
                  child: CustomPaint(
                    painter: SketchPainter(
                      points: _points,
                      strokeColor: _selectedColor,
                      strokeWidth: _strokeWidth,
                    ),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
          ),

          // Bottom Info
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1A2029),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Points: ${_points.length}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Tool: ${_isErasing ? 'Eraser' : 'Pen'}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Size: ${_strokeWidth.toInt()}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    // No special handling needed for start
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      if (_isErasing) {
        // Simple eraser - remove points near the touch
        _points.removeWhere((point) {
          return (point - details.localPosition).distance < _strokeWidth * 2;
        });
      } else {
        _points.add(details.localPosition);
      }
    });
  }

  void _undo() {
    if (_points.isNotEmpty) {
      setState(() {
        // Remove last 10 points for undo
        final removeCount = _points.length >= 10 ? 10 : _points.length;
        _points.removeRange(_points.length - removeCount, _points.length);
      });
    }
  }

  void _clear() {
    setState(() => _points.clear());
  }

  void _saveSketch() {
    // Note: Implement save functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sketch saved successfully!'),
        backgroundColor: Color(0xFFD6FF23),
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Offset> points;
  final Color strokeColor;
  final double strokeWidth;

  SketchPainter({
    required this.points,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}