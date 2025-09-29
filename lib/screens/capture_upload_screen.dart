import 'package:flutter/material.dart';
// import 'package:camera/camera.dart'; 
// import 'package:image_picker/image_picker.dart';
import 'kolam_analysis_screen.dart'; // Import KolamAnalysisScreen
import 'dart:io'; // For File type

class CaptureUploadScreen extends StatefulWidget {
  const CaptureUploadScreen({super.key});

  @override
  State<CaptureUploadScreen> createState() => _CaptureUploadScreenState();
}

class _CaptureUploadScreenState extends State<CaptureUploadScreen> {
  // CameraController? _cameraController;
  // List<CameraDescription>? _cameras;
  File? _capturedImage;
  File? _uploadedImage;

  @override
  void initState() {
    super.initState();
    // _initializeCamera();
  }

  // Future<void> _initializeCamera() async {
  //   // _cameras = await availableCameras();
  //   // if (_cameras != null && _cameras!.isNotEmpty) {
  //   //   _cameraController = CameraController(_cameras![0], ResolutionPreset.high);
  //   //   await _cameraController!.initialize();
  //   //   if (mounted) setState(() {});
  //   // }
  //   print("Camera initialization placeholder");
  // }

  Future<void> _captureImage() async {
    print("Capture image placeholder");
    // Simulate capture for UI update and navigation
    // In a real app, this File would come from the camera plugin
    final String fakeImagePath = 'path/to/fake_captured_image_${DateTime.now().millisecondsSinceEpoch}.png';
    setState(() => _capturedImage = File(fakeImagePath)); 
    if (_capturedImage != null && mounted) _proceedToAnalysis(_capturedImage!); 
  }

  Future<void> _uploadImage() async {
    print("Upload image placeholder");
    // Simulate upload for UI update and navigation
    // In a real app, this File would come from the image_picker plugin
    final String fakeImagePath = 'path/to/fake_uploaded_image_${DateTime.now().millisecondsSinceEpoch}.png';
    setState(() => _uploadedImage = File(fakeImagePath));
    if (_uploadedImage != null && mounted) _proceedToAnalysis(_uploadedImage!); 
  }

  void _proceedToAnalysis(File imageFile) {
    print("Proceeding to Kolam Analysis with image: ${imageFile.path}");
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KolamAnalysisScreen(imageFile: imageFile)),
      );
    }
  }

  @override
  void dispose() {
    // _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;

    Widget cameraPreviewSection = Expanded(
      flex: isWideScreen ? 1 : 0, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1.0, 
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: const Center(child: Icon(Icons.camera_alt, size: 100, color: Colors.grey)), 
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.camera), 
            label: const Text("Capture"),
            onPressed: _captureImage,
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
          ),
        ],
      ),
    );

    Widget uploadSection = Expanded(
      flex: isWideScreen ? 1 : 0, 
      child: InkWell( 
        onTap: _uploadImage, 
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, style: BorderStyle.solid, width: 2), 
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.blue.withOpacity(0.05),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_upload_outlined, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 16),
              const Text("Upload Image", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              const SizedBox(height: 8),
              const Text("Tap or drag & drop here", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              if (_uploadedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Placeholder: ${_uploadedImage!.path.split('/').last}", style: const TextStyle(color: Colors.green, fontSize: 12)),
                ),
              if (_capturedImage != null)
                 Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Placeholder: ${_capturedImage!.path.split('/').last}", style: const TextStyle(color: Colors.green, fontSize: 12)),
                ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Capture or Upload Kolam")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isWideScreen 
            ? Row(children: [cameraPreviewSection, uploadSection]) 
            : Column(children: [Expanded(child: cameraPreviewSection), Expanded(child: uploadSection)])
      ),
    );
  }
}
