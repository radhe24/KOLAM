import 'package:flutter/material.dart';

// import '../widgets/kolam_canvas_painter.dart';
// import '../models/kolam_design_model.dart';

class KolamRecreatorScreen extends StatefulWidget {
  const KolamRecreatorScreen({super.key});

  @override
  State<KolamRecreatorScreen> createState() => _KolamRecreatorScreenState();
}

class _KolamRecreatorScreenState extends State<KolamRecreatorScreen> {
  String _selectedTool = 'line';
  Color _selectedColor = Colors.black;
  bool _isSymmetryEnabled = false;
  bool _isGuideModeEnabled = false;
  int _currentGuideStep = 0;
  final int _totalGuideSteps = 10; // Example total steps

  // List<DrawingPath> _paths = [];
  double _zoomLevel = 1.0;

  void _selectTool(String tool) {
    setState(() => _selectedTool = tool);
    print("Tool selected: $tool");
  }

  void _selectColor(Color color) {
    setState(() => _selectedColor = color);
    print("Color selected: $color");
  }

  void _toggleSymmetry() {
    setState(() => _isSymmetryEnabled = !_isSymmetryEnabled);
    print("Symmetry: ${_isSymmetryEnabled ? 'ON' : 'OFF'}");
  }

  void _toggleGuideMode() {
    setState(() {
      _isGuideModeEnabled = !_isGuideModeEnabled;
      _currentGuideStep = 0; // Reset guide on toggle
    });
    print("Guide Mode: ${_isGuideModeEnabled ? 'ON' : 'OFF'}");
  }

  void _undoLastAction() {
    print("Undo action (placeholder)");
  }

  void _redoLastAction() {
    print("Redo action (placeholder)");
  }

  void _saveKolam() {
    print("Save Kolam action (placeholder)");
  }

  void _exportKolam() {
    print("Export Kolam action (placeholder)");
  }

  void _aiSuggestCreativity() {
    print("AI Suggest Creativity action (placeholder)");
  }
  
  void _onCanvasTap(Offset position) {
    print("Canvas tapped at $position with tool: $_selectedTool, color: $_selectedColor");
    if (_isGuideModeEnabled && _currentGuideStep < _totalGuideSteps -1) {
        setState(() => _currentGuideStep++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kolam Recreator"),
        actions: [
          IconButton(icon: const Icon(Icons.save_alt_outlined), onPressed: _saveKolam, tooltip: "Save"),
          IconButton(icon: const Icon(Icons.ios_share_outlined), onPressed: _exportKolam, tooltip: "Export"),
        ],
      ),
      body: Row(
        children: <Widget>[
          Container(
            width: 80, // Adjust width as needed
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            color: Colors.grey[200], // Example background color
            child: Column(
              children: <Widget>[
                IconButton(icon: Icon(Icons.color_lens_outlined, color: _selectedColor), onPressed: () { _selectColor(Colors.blue); }),
                _buildToolButton(icon: Icons.edit_outlined, toolName: 'line', label: 'Line'),
                _buildToolButton(icon: Icons.circle_outlined, toolName: 'circle', label: 'Circle'),
                _buildToolButton(icon: Icons.crop_square_outlined, toolName: 'square', label: 'Square'),
                const Divider(),
                SwitchListTile(title: const Text("Sym"), value: _isSymmetryEnabled, onChanged: (val) => _toggleSymmetry(), secondary: const Icon(Icons.flip_outlined)), // Compact
                SwitchListTile(title: const Text("Guide"), value: _isGuideModeEnabled, onChanged: (val) => _toggleGuideMode(), secondary: const Icon(Icons.help_outline)), // Compact
                const Spacer(),
                IconButton(icon: const Icon(Icons.lightbulb_outline), onPressed: _aiSuggestCreativity, tooltip: "AI Suggest"),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                if (_isGuideModeEnabled)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Step ${_currentGuideStep + 1}/$_totalGuideSteps", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                Expanded(
                  child: GestureDetector(
                    onTapUp: (details) => _onCanvasTap(details.localPosition),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.white, 
                      ),
                      // child: CustomPaint(
                      //   painter: KolamCanvasPainter(paths: _paths, gridDots: [], guideStep: _isGuideModeEnabled ? _currentGuideStep : null),
                      //   size: Size.infinite,
                      // ),
                      child: const Center(child: Text("Drawing Canvas Area\n(Grid, Dots, Lines, Curves)")),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: const Icon(Icons.undo), onPressed: _undoLastAction, tooltip: "Undo"),
                      IconButton(icon: const Icon(Icons.redo), onPressed: _redoLastAction, tooltip: "Redo"),
                      // IconButton(icon: Icon(Icons.zoom_in), onPressed: () => setState(() => _zoomLevel *= 1.2)),
                      // IconButton(icon: Icon(Icons.zoom_out), onPressed: () => setState(() => _zoomLevel /= 1.2)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({required IconData icon, required String toolName, required String label}) {
    bool isSelected = _selectedTool == toolName;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700]),
      tooltip: label,
      onPressed: () => _selectTool(toolName),
    );
  }
}

// - Drawing grid (dots, lines, curves)
// - Drawing user paths (lines, shapes) with selected color and tool
// - Applying symmetry if enabled
// - Showing guide steps (animating next step)
// - Handling zoom/pan transformations if not done by InteractiveViewer
