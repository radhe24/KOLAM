import 'package:flutter/material.dart';

class HeritageDetailScreen extends StatefulWidget {
  final String topicTitle;
  final List<Map<String, String>> contentItems;

  const HeritageDetailScreen({
    super.key,
    required this.topicTitle,
    required this.contentItems,
  });

  @override
  State<HeritageDetailScreen> createState() => _HeritageDetailScreenState();
}

class _HeritageDetailScreenState extends State<HeritageDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    int itemCount = widget.contentItems.length;
    final int baseDurationMs = 500;
    final int perItemMs = 100;
    final int totalDuration = baseDurationMs + (itemCount * perItemMs);

    _animationController = AnimationController(
      duration: Duration(milliseconds: totalDuration.clamp(baseDurationMs, 2500)),
      vsync: this,
    );

    _cardAnimations = List.generate(
      itemCount,
      (index) {
        double unit = 1.0 / itemCount;
        double start = (index * unit * 0.5).clamp(0.0, 1.0);
        double end = (start + unit * 1.5).clamp(0.0, 1.0);
        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          ),
        );
      },
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  IconData _getPlaceholderIcon(String? imageHint) {
    switch (imageHint) {
      case 'pulli':
        return Icons.grid_on_outlined;
      case 'sikku':
        return Icons.gesture_outlined;
      case 'padi':
        return Icons.stairs_outlined;
      case 'rangoli':
        return Icons.palette_outlined;
      case 'chukkala':
        return Icons.scatter_plot_outlined;
      case 'regional':
        return Icons.public_outlined;
      case 'variations':
        return Icons.celebration_outlined;
      case 'materials':
        return Icons.handyman_outlined;
      case 'techniques':
        return Icons.draw_outlined;
      case 'math':
        return Icons.calculate_outlined;
      case 'spiritual_social':
        return Icons.groups_outlined;
      case 'overview':
        return Icons.info_outline_rounded;
      default:
        return Icons.image_search_outlined;
    }
  }

  Widget _buildDetailItemCard(
      BuildContext context, Map<String, String> item, Animation<double> animation) {
    if (widget.topicTitle == "Types of Kolam") {
      IconData placeholderIcon = _getPlaceholderIcon(item['imageHint']);
      String? imageHint = item['imageHint'];

      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.15),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.decelerate)).animate(animation),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Box (Left)
                Container(
                  width: 75,
                  height: 75,
                  margin: const EdgeInsets.only(right: 16.0),
                  clipBehavior: Clip.antiAlias, // Ensures child respects border radius
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey.shade300, width: 0.8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: imageHint != null && imageHint.isNotEmpty
                      ? Image.asset(
                          'assets/images/kolam_types/$imageHint.png', // Assumes PNG files
                          fit: BoxFit.cover, // Or BoxFit.contain, depending on your images
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to placeholder icon if image fails to load
                            return Center(
                              child: Icon(
                                placeholderIcon,
                                size: 38,
                                color: Colors.grey.shade400,
                              ),
                            );
                          },
                        )
                      : Center( // Fallback if no imageHint is provided
                          child: Icon(
                            placeholderIcon,
                            size: 38,
                            color: Colors.grey.shade400,
                          ),
                        ),
                ),
                // Content Box (Right)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey.shade200, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item["title"] != null && item["title"]!.isNotEmpty)
                          Text(
                            item["title"]!,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        if (item["title"] != null && item["title"]!.isNotEmpty)
                          const SizedBox(height: 8.0),
                        Text(
                          item["detail"]!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade800,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Existing full-width card layout for other topics
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.15),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.decelerate)).animate(animation),
          child: Card(
            elevation: 2.5,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item["title"] != null && item["title"]!.isNotEmpty)
                    Text(
                      item["title"]!,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.85),
                      ),
                    ),
                  if (item["title"] != null && item["title"]!.isNotEmpty)
                    const SizedBox(height: 10.0),
                  Text(
                    item["detail"]!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.grey.shade700,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget.topicTitle),
        backgroundColor: const Color(0xFFB71C1C),
        elevation: 2.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
            itemCount: widget.contentItems.length,
            itemBuilder: (context, index) {
              return _buildDetailItemCard(
                  context, widget.contentItems[index], _cardAnimations[index]);
            },
          ),
        ),
      ),
    );
  }
}
