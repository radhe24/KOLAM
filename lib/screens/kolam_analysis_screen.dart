import 'package:flutter/material.dart';
import 'dart:io'; // For File type

// import '../models/kolam_analysis_model.dart';

class KolamAnalysisScreen extends StatefulWidget {
  final File? imageFile; // Image passed from capture/upload screen

  const KolamAnalysisScreen({super.key, this.imageFile});

  @override
  State<KolamAnalysisScreen> createState() => _KolamAnalysisScreenState();
}

class _KolamAnalysisScreenState extends State<KolamAnalysisScreen> {
  // Example: List<PatternData> _patterns = [];
  // Example: SymmetryData _symmetryData = SymmetryData();
  bool _isSidebarOpen = false; // For slide-out/expanding panel
  String _selectedPrincipleTab = "Symmetry"; // Default tab

  final List<Map<String, dynamic>> _pastAnalyses = [
    {'id': '1', 'thumbnailUrl': 'https://via.placeholder.com/100/FF0000/FFFFFF?Text=Past1'},
    {'id': '2', 'thumbnailUrl': 'https://via.placeholder.com/100/00FF00/FFFFFF?Text=Past2'},
    {'id': '3', 'thumbnailUrl': 'https://via.placeholder.com/100/0000FF/FFFFFF?Text=Past3'},
  ];
  int _currentPastAnalysisIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.imageFile != null) {
      print("AI Analysis started for: ${widget.imageFile!.path}");
    }
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _selectPrincipleTab(String tabName) {
    setState(() {
      _selectedPrincipleTab = tabName;
    });
  }

  void _saveAnalysis() {
    print("Save analysis action (placeholder)");
  }

  void _shareAnalysis() {
    print("Share analysis action (placeholder)");
  }

  void _downloadAnalysis() {
    print("Download analysis action (placeholder)");
  }

  void _selectPastAnalysis(int index) {
    setState(() {
      _currentPastAnalysisIndex = index;
      print("Selected past analysis: ${_pastAnalyses[index]['id']}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kolam Analysis"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline), 
            onPressed: _toggleSidebar, // Or open a dedicated info panel
            tooltip: "Design Principles",
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Center display of Kolam image with overlays
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8.0),
                    image: widget.imageFile != null 
                        ? DecorationImage(image: FileImage(widget.imageFile!), fit: BoxFit.contain)
                        : null,
                  ),
                  // This child could be a Stack with the Image and CustomPaint widgets
                  child: widget.imageFile == null 
                      ? const Center(child: Text("No image selected for analysis."))
                      : InteractiveViewer(
                          child: CustomPaint(
                            size: Size.infinite,
                            // painter: KolamOverlayPainter(analysisData: _analysisData), // Pass analysis data to painter
                            child: Center(
                              child: widget.imageFile != null 
                                ? Image.file(widget.imageFile!, fit: BoxFit.contain) 
                                : const Text("Loading Image...")
                            ),
                          ),
                        ),
                ),
              ),
              // Carousel for past analyses
              Container(
                height: 120,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.grey[200],
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _pastAnalyses.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _selectPastAnalysis(index),
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _currentPastAnalysisIndex == index ? Theme.of(context).primaryColor : Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(_pastAnalyses[index]['thumbnailUrl']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Action Buttons: Save, Share, Download
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton.icon(icon: const Icon(Icons.save_alt_outlined), label: const Text("Save"), onPressed: _saveAnalysis ),
                    ElevatedButton.icon(icon: const Icon(Icons.share_outlined), label: const Text("Share"), onPressed: _shareAnalysis ),
                    ElevatedButton.icon(icon: const Icon(Icons.download_outlined), label: const Text("Download"), onPressed: _downloadAnalysis),
                  ],
                ),
              ),
            ],
          ),
          // Sidebar (slide-out/expanding panel)
          if (_isSidebarOpen)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.75, // Example width
              child: Material(
                elevation: 8.0,
                child: Container(
                  color: Theme.of(context).canvasColor, // Or a slightly different bg color
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Design Principles", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(icon: const Icon(Icons.close), onPressed: _toggleSidebar),
                        ],
                      ),
                      const Divider(),
                      _buildPrincipleTab("Symmetry"),
                      _buildPrincipleTab("Repetition"),
                      _buildPrincipleTab("Balance"),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text("Details about $_selectedPrincipleTab will be shown here. This could include text, diagrams, or interactive elements related to the current Kolam."),
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

  Widget _buildPrincipleTab(String title) {
    bool isSelected = _selectedPrincipleTab == title;
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      onTap: () => _selectPrincipleTab(title),
      selected: isSelected,
    );
  }
}

// This painter will take analysis data (lines, dots, patterns) and draw them over the image.
// It should handle:
// - Highlighting symmetry lines
// - Showing patterns
// - Marking design principles
// - Interactive tap for pop-out detail on elements (might need gesture detectors on the CustomPaint)
