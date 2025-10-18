import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShapesToolScreen extends StatefulWidget {
  const ShapesToolScreen({super.key});

  @override
  State<ShapesToolScreen> createState() => _ShapesToolScreenState();
}

class _ShapesToolScreenState extends State<ShapesToolScreen> {
  final List<Map<String, dynamic>> _shapes = [];
  String _selectedShape = 'rectangle';
  Color _selectedColor = Colors.blue;
  double _strokeWidth = 2.0;

  final List<String> _shapeTypes = [
    'rectangle',
    'circle',
    'triangle',
    'line',
    'polygon',
    'star',
  ];

  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
  ];

  final List<double> _strokeWidths = [1.0, 2.0, 4.0, 6.0, 8.0];

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
          'Shapes Tool',
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
            onPressed: _saveShapes,
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Shape Selection
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E131A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF2A2F38)),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedShape,
                      dropdownColor: const Color(0xFF1A2029),
                      style: const TextStyle(color: Colors.white),
                      underline: const SizedBox(),
                      items: _shapeTypes.map((shape) {
                        return DropdownMenuItem(
                          value: shape,
                          child: Text(
                            shape[0].toUpperCase() + shape.substring(1),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedShape = value);
                        }
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Color Palette
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _colors.length,
                      itemBuilder: (context, index) {
                        final color = _colors[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedColor = color);
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedColor == color
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

                  const SizedBox(width: 16),

                  // Stroke Width
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E131A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF2A2F38)),
                    ),
                    child: DropdownButton<double>(
                      value: _strokeWidth,
                      dropdownColor: const Color(0xFF1A2029),
                      style: const TextStyle(color: Colors.white),
                      underline: const SizedBox(),
                      items: _strokeWidths.map((width) {
                        return DropdownMenuItem(
                          value: width,
                          child: Text(
                            '${width.toInt()}px',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _strokeWidth = value);
                        }
                      },
                    ),
                  ),
                ],
              ),
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
                  onTapDown: _onTapDown,
                  child: CustomPaint(
                    painter: ShapesPainter(shapes: _shapes),
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
                  'Shapes: ${_shapes.length}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Selected: ${_selectedShape[0].toUpperCase() + _selectedShape.substring(1)}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Size: ${_strokeWidth.toInt()}px',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _shapes.add({
        'type': _selectedShape,
        'position': details.localPosition,
        'color': _selectedColor,
        'strokeWidth': _strokeWidth,
        'size': 80.0, // Default size
      });
    });
  }

  void _undo() {
    if (_shapes.isNotEmpty) {
      setState(() {
        _shapes.removeLast();
      });
    }
  }

  void _clear() {
    setState(() => _shapes.clear());
  }

  void _saveShapes() {
    // Note: Implement save functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Shapes saved successfully!'),
        backgroundColor: Color(0xFFD6FF23),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final List<Map<String, dynamic>> shapes;

  ShapesPainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    for (final shape in shapes) {
      final paint = Paint()
        ..color = shape['color']
        ..strokeWidth = shape['strokeWidth']
        ..style = PaintingStyle.stroke;

      final position = shape['position'] as Offset;
      final shapeSize = shape['size'] as double;

      switch (shape['type']) {
        case 'rectangle':
          canvas.drawRect(
            Rect.fromCenter(
              center: position,
              width: shapeSize,
              height: shapeSize * 0.6,
            ),
            paint,
          );
          break;

        case 'circle':
          canvas.drawCircle(position, shapeSize / 2, paint);
          break;

        case 'triangle':
          final path = Path();
          path.moveTo(position.dx, position.dy - shapeSize / 2);
          path.lineTo(position.dx - shapeSize / 2, position.dy + shapeSize / 2);
          path.lineTo(position.dx + shapeSize / 2, position.dy + shapeSize / 2);
          path.close();
          canvas.drawPath(path, paint);
          break;

        case 'line':
          canvas.drawLine(
            Offset(position.dx - shapeSize / 2, position.dy),
            Offset(position.dx + shapeSize / 2, position.dy),
            paint,
          );
          break;

        case 'polygon':
          _drawPolygon(canvas, position, 6, shapeSize / 2, paint);
          break;

        case 'star':
          _drawStar(canvas, position, shapeSize / 2, paint);
          break;
      }
    }
  }

  void _drawPolygon(Canvas canvas, Offset center, int sides, double radius, Paint paint) {
    final path = Path();
    final angle = (2 * 3.14159) / sides;

    for (int i = 0; i < sides; i++) {
      final x = center.dx + radius * (i == 0 ? 0 : math.cos(i * angle));
      final y = center.dy + radius * (i == 0 ? -1 : -math.sin(i * angle));

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    final outerRadius = radius;
    final innerRadius = radius * 0.5;
    final angle = 3.14159 / 5; // 36 degrees

    for (int i = 0; i < 10; i++) {
      final r = i.isEven ? outerRadius : innerRadius;
      final x = center.dx + r * math.cos(i * angle);
      final y = center.dy + r * -math.sin(i * angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}