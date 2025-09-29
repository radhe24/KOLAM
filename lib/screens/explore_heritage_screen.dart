import 'package:flutter/material.dart';
import 'heritage_detail_screen.dart'; // Import the new detail screen

class ExploreHeritageScreen extends StatefulWidget {
  const ExploreHeritageScreen({super.key});

  @override
  State<ExploreHeritageScreen> createState() => _ExploreHeritageScreenState();
}

class _ExploreHeritageScreenState extends State<ExploreHeritageScreen>
    with SingleTickerProviderStateMixin {
  // Define Colors
  static const Color _richRedBackground = Color(0xFFB71C1C);
  static const Color _appBarColor = Color(0xFFB71C1C);
  static const Color _topCardPlaceholderColor = Color(0xFFA5D6A7); // Light Green
  static const Color _smallCardBackground = Colors.white;
  static const Color _smallCardIconColor = Color(0xFF1976D2); // Blue
  static const Color _bottomNavSelectedColor = Color(0xFF6A1B9A); // Purple

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Updated Origins Content
  static final List<Map<String, String>> originsContent = [
    {
      "title": "Unveiling Kolam's Ancient Roots",
      "detail": "Journey through the multifaceted origins of Kolam, an art form deeply embedded in history, mathematics, ecology, and cultural narratives. Discover how this tradition has evolved and sustained its significance through millennia.",
      "imageHint": "origins_intro",
    },
    {
      "title": "Anthropological Evidence",
      "detail": "Explore Kolam's connections to prehistoric tribal body art and ground paintings, suggesting origins that predate written history and highlight its role in early human symbolic expression.",
      "imageHint": "anthropology",
    },
    {
      "title": "Symbolic Mathematical Codes",
      "detail": "Delve into the intricate mathematical principles woven into Kolam designs, including prime numbers, palindromes, and binary patterns, hinting at a sophisticated system of encoded knowledge.",
      "imageHint": "math_codes",
    },
    {
      "title": "Ecological Functions",
      "detail": "Understand Kolam's role as 'ecosystem engineering,' where the traditional use of rice flour nourishes insects and birds, integrating art with the local food web and promoting biodiversity.",
      "imageHint": "ecology",
    },
    {
      "title": "Gender and Cultural Identity",
      "detail": "Learn about Kolam as a predominantly matrilineal art form, crucial in preserving female cultural roles, fostering social networks, and transmitting familial identity across generations.",
      "imageHint": "gender_identity",
    },
    {
      "title": "Cross-Cultural Parallels",
      "detail": "Discover parallels between Kolam motifs and geometric patterns found in indigenous arts worldwide, suggesting universal themes in human artistic expression or ancient cross-cultural exchanges.",
      "imageHint": "cross_cultural",
    },
    {
      "title": "Kolam in Ancient Scripts and Folk Tales",
      "detail": "Examine references to Kolam in ancient Tamil literature and folk narratives, which often attribute divine origins to the art and underscore its importance in daily rituals and societal beliefs.",
      "imageHint": "scripts_folktales",
    },
    {
      "title": "Transformation Through Time",
      "detail": "Trace Kolam's evolution through various historical periods, adapting to trade interactions, colonial influences, and urbanization, reflected in its motifs, materials, and practices.",
      "imageHint": "transformation_time",
    },
    {
      "title": "Use in Healing and Meditation",
      "detail": "Explore the meditative aspects of creating Kolam, a practice known to promote mindfulness and concentration, with some traditions associating specific patterns with healing properties.",
      "imageHint": "healing_meditation",
    },
    {
      "title": "Material Evolution Evidence",
      "detail": "Investigate archaeological findings, including remnants of mineral-based pigments, which provide evidence of the evolving materials used in Kolam beyond traditional rice flour.",
      "imageHint": "material_evolution",
    },
    {
      "title": "Community Rituals and Festivals",
      "detail": "Witness Kolam's central role in community rituals and festivals, often featuring large-scale creations, competitions, and events that merge art with music, dance, and storytelling.",
      "imageHint": "community_rituals",
    }
  ];

  static final List<Map<String, String>> typesContent = [
    {
      "title": "Understanding Kolam Types",
      "detail":
          "Kolams, a rich and diverse form of traditional Indian art especially popular in Tamil Nadu, come in several distinctive types. Each type reflects unique regional styles, materials, and cultural meanings. Understanding these varieties enriches appreciation of this art form:",
      "imageHint": "overview",
    },
    {
      "title": "1. Pulli Kolam (Dot Kolam)",
      "detail":
          "- The simplest and most traditional form using a grid of dots (pulli).\n- Lines are drawn to connect these dots, forming intricate, often symmetrical designs.\n- Typically created with rice flour, welcoming prosperity.",
      "imageHint": "pulli",
    },
    {
      "title": "2. Sikku Kolam (Loop Kolam)",
      "detail":
          "- Based on continuous looping lines around the dots without lifting the hand.\n- Symbolizes continuity and eternity.\n- Often more complex than Pulli Kolam and requires precision.",
      "imageHint": "sikku",
    },
    {
      "title": "3. Padi Kolam",
      "detail":
          "- Characterized by more intricate patterns with multiple layers around dots.\n- These Kolams have step-like structures (\"padi\" means step).",
      "imageHint": "padi",
    },
    {
      "title": "4. Rangoli",
      "detail":
          "- Usually made during festivals with colored powders, flowers, and sometimes sand.\n- Incorporates freehand designs and symbolic motifs, often larger and more colorful.",
      "imageHint": "rangoli",
    },
    {
      "title": "5. Chukkala Kolam",
      "detail":
          "- A dotted Kolam printed using stamp-like tools for efficiency and uniformity in repetitive designs.",
      "imageHint": "chukkala",
    },
    {
      "title": "6. Other Regional Variants",
      "detail":
          "- Muggu (Telangana, Andhra Pradesh) and Rangavalli (Karnataka) share similarities but use different coloring techniques and motifs.",
      "imageHint": "regional",
    },
    {
      "title": "7. Occasion-based Variations",
      "detail":
          "- Kolams designed for everyday use are simpler, while festival Kolams are elaborate and vibrant.",
      "imageHint": "variations",
    },
    {
      "title": "8. Materials & Tools",
      "detail":
          "- Traditional Kolams use rice flour (eco-friendly & feeding insects), chalk, or synthetic colors.",
      "imageHint": "materials",
    },
    {
      "title": "9. Techniques",
      "detail":
          "- Techniques vary—freehand drawing, stencil use, or digital representation in modern adaptations.",
      "imageHint": "techniques",
    },
    {
      "title": "10. Mathematical Principles",
      "detail":
          "- Symmetry, fractal patterns, recursion, and geometric progressions underpin all types.",
      "imageHint": "math",
    },
    {
      "title": "11. Spiritual & Social Significance (of Types)", 
      "detail":
          "- Each Kolam type carries distinct auspicious and symbolic meaning tied to rituals and community harmony.",
      "imageHint": "spiritual_social",
    }
  ];

  static final List<Map<String, String>> significanceContent = [
    {
      "title": "The Cultural Heart of Kolam",
      "detail":
          "Kolam art is not merely decorative; it is deeply embedded in the social, spiritual, and environmental fabric of life. Here's why it matters culturally:",
      "imageHint": "overview",
    },
    {
      "title": "1. Daily Ritual & Tradition",
      "detail":
          "- Drawn daily at thresholds to welcome deities and guests, marking hospitality.\n- Maintains ritual purity by sweeping away ill fortune and inviting well-being.",
      // "imageHint": "ritual", 
    },
    {
      "title": "2. Auspicious Symbolism",
      "detail":
          "- Integral to festivals like Pongal, Diwali, Navaratri—each Kolam motif carries symbols of prosperity, fertility, and cosmic forces.",
      // "imageHint": "symbolism", 
    },
    {
      "title": "3. Eco-Friendly Practice",
      "detail":
          "- Made with biodegradable materials (rice flour) that feed birds and insects, supporting local ecosystems.",
    },
    {
      "title": "4. Women’s Cultural Role",
      "detail":
          "- Traditionally created by women, Kolam strengthens social bonds and family identity.\n- Passed down mother-to-daughter as a legacy of artistry and spirituality.",
    },
    {
      "title": "5. Social Geometry",
      "detail":
          "- Community Kolam events encourage cooperation, creativity, and cultural pride.",
    },
    {
      "title": "6. Religious Connection",
      "detail":
          "- Seen as an offering to gods, especially on occasions of temple processions or family ceremonies.",
    },
    {
      "title": "7. Educational Aspect",
      "detail":
          "- Kolam's repetitive and patterned nature helps nurture focus, fine motor skills, and aesthetic sensibility.",
    },
    {
      "title": "8. Symbol of Harmony",
      "detail":
          "- Designs harmonize human action with the cyclical patterns of nature, echoing rhythms of seasons and harvest.",
    },
    {
      "title": "9. Adaptations in Modern Life",
      "detail":
          "- Embodying cultural storytelling in contemporary art, digital media, and public displays.",
    },
    {
      "title": "10. Cultural Identity",
      "detail":
          "- Kolam serves as a living emblem of Tamil and South Indian heritage, recognized worldwide.",
    }
  ];

  static final List<Map<String, String>> modernAdaptationsContent = [
    {
      "title": "Kolam in the 21st Century",
      "detail":
          "Kolam art gracefully transitions into the 21st century, embracing technology and new cultural contexts:",
      "imageHint": "overview",
    },
    {
      "title": "1. Digital Preservation",
      "detail":
          "- Apps like Suvarna Rekha archive patterns, ensuring survival beyond oral and practice traditions.",
    },
    {
      "title": "2. AI and Computer Vision",
      "detail":
          "- Use of AI to decode symmetry and meaning, offering educational tools and design assistance.",
    },
    {
      "title": "3. Interactive Learning",
      "detail":
          "- Interactive games linked with Kolam help teach math concepts, pattern recognition, and spatial intelligence.",
    },
    {
      "title": "4. Artistic Innovations",
      "detail":
          "- Artists incorporate Kolam motifs into fabrics, graphic design, and contemporary installations.",
    },
    {
      "title": "5. Global Exhibitions",
      "detail":
          "- Kolam-inspired art is increasingly showcased in galleries worldwide, connecting cultures.",
    },
    {
      "title": "6. STEM Integration",
      "detail":
          "- Kolam mathematics inspires teaching models in geometry, recursion, and biology.",
    },
    {
      "title": "7. Virtual Reality (VR) and Augmented Reality (AR)",
      "detail":
          "- Emerging platforms allow immersive Kolam experiences blending tradition with technology.",
    },
    {
      "title": "8. Eco-Friendly Festivals",
      "detail":
          "- Digital Kolam and eco-conscious materials promote sustainable cultural practices.",
    },
    {
      "title": "9. Community Engagement",
      "detail":
          "- Online galleries and contests foster global connections among Kolam enthusiasts.",
    },
    {
      "title": "10. Youth Involvement",
      "detail":
          "- Modern platforms engage younger generations preserving cultural heritage creatively.",
    }
  ];


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _richRedBackground,
      appBar: AppBar(
        backgroundColor: _appBarColor,
        elevation: 0,
        title: FadeTransition(
          opacity: _fadeAnimation,
          child: const Text('Explore Kolam Heritage', style: TextStyle(color: Colors.white)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () { /* TODO: Implement search */ },
            ),
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () { /* TODO: Implement menu */ },
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTopKolamCard(context),
                  const SizedBox(height: 24.0),
                  _buildGridCards(context),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildTopKolamCard(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        elevation: 4.0,
        color: _topCardPlaceholderColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Kolam: A Timeless Tradition',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(blurRadius: 1.0, color: Colors.black54, offset: Offset(0.5, 0.5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCards(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildSmallCard(
                  context,
                  title: 'Origins of Kolam',
                  icon: Icons.history_edu_outlined,
                  contentItems: originsContent, // Pass the new detailed originsContent
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSmallCard(
                  context,
                  title: 'Types of Kolam',
                  icon: Icons.category_outlined,
                  contentItems: typesContent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildSmallCard(
                  context,
                  title: 'Cultural Significance',
                  icon: Icons.brightness_auto_outlined,
                  contentItems: significanceContent,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSmallCard(
                  context,
                  title: 'Modern Adaptations',
                  icon: Icons.architecture_outlined,
                  contentItems: modernAdaptationsContent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Map<String, String>> contentItems,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HeritageDetailScreen(
              topicTitle: title,
              contentItems: contentItems,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        color: _smallCardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 40.0, color: _smallCardIconColor),
              const SizedBox(height: 12.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: _bottomNavSelectedColor,
      unselectedItemColor: Colors.grey.shade600,
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
      onTap: (index) {
        print('Tapped item $index');
      },
    );
  }
}
