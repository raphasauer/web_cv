class ResumeData {
  static const String name = "Raphael Sauer de Castro";
  static const String title = "Software Engineer";
  static const String email = "raphasauer@gmail.com";
  static const String location = "São Carlos, SP, Brazil";
  static const String linkedIn = "www.linkedin.com/in/raphael-de-castro-228288202";
  static const String github = "https://github.com/raphasauer"; 

  static const String introText = 
      "High-performance Software Engineer specializing in Mobile (Flutter) and "
      "Backend (Python/Django) architecture. Currently engineering premium "
      "digital experiences for BMW & MINI at Ília. I bridge the gap between "
      "complex embedded hardware and seamless user interfaces, delivering "
      "scalable solutions for global markets.";

  static const Map<String, dynamic> impactStats = {
    'experience': {'count': '5+', 'label': 'Years Experience'},
    'projects': {'count': '50+', 'label': 'Markets served'},
    'reviews': {'count': '4.5+', 'label': 'Store reviews'},
    'users': {'count': '15 M', 'label': 'Users worldwide'},
  };

  static const List<Map<String, String>> collaborationCountries = [
    {'name': 'United States', 'code': 'US'},
    {'name': 'Germany', 'code': 'DE'},
    {'name': 'Spain', 'code': 'ES'},
    {'name': 'Japan', 'code': 'JP'},
    {'name': 'South Korea', 'code': 'KR'},
    {'name': 'Brazil', 'code': 'BR'},
    {'name': 'South Africa', 'code': 'ZA'},
    {'name': 'China', 'code': 'CN'},
    {'name': 'Portugal', 'code': 'PT'},
    {'name': 'India', 'code': 'IN'},

  ];

  // Helper to get just country names
  static List<String> get collaborationCountryNames =>
      collaborationCountries.map((c) => c['name']!).toList();

  // Helper to get just country codes
  static List<String> get collaborationCountryCodes =>
      collaborationCountries.map((c) => c['code']!).toList();

  static const List<Map<String, dynamic>> apps = [
{
      'name': 'MyBMW',
      'logo': 'assets/app_logos/my_bmw.webp',
      'color': 0xFF2998FF, 
      'description': 'Premium automotive companion app',
      'achievement': 'Reducing number of requests of a feature using Bloc / cache, saving thousands of euros in cloud costs',
      'users': '10 million worldwide',
      'platform': 'iOS & Android',
    },
    {
      'name': 'MINI',
      'logo': 'assets/app_logos/mini.webp',
      'color': 0xFF00C853, 
      'description': 'Automotive companion app',
      'achievement': 'Reducing support load with AI-based chatbot for support, saving hundreds of hours of support time',
      'users': '2 million worldwide',
      'platform': 'iOS & Android',
    },
    {
      'name': 'Toyota Supra Connect',
      'logo': 'assets/app_logos/supra.webp',
      'color': 0xFFFF2D55, 
      'description': 'Sports car companion app',
      'achievement': 'Bug fixes and performance improvements to enhance user experience',
      'users': 'thousands worldwide',
      'platform': 'iOS & Android',
    },
    {
      'name': 'Kindra Count',
      'logo': 'assets/app_logos/kindra_count.webp',
      'color': 0xFF5C9DFF, 
      'description': 'IoT Animal Counting Solution',
      'achievement': 'Architected entire ecosystem: Mobile HMI, Python Backend & Embedded C++',
      'users': '500+ producers; millions of animals counted',
      'platform': 'Android, desktop and web',
    },
    {
      'name': 'Seta Analytics',
      'logo': 'assets/app_logos/seta_analytics.webp',
      'color': 0xFFA55BF7, 
      'description': 'Business inteligence for retail',
      'achievement': 'Led integration of Stone Co. analytics company into Linx retails analytics app',
      'users': '5 thousand retail stores all over Brazil',
      'platform': 'Android, iOS',
    },
    {
      'name': 'Seta Coletor',
      'logo': 'assets/app_logos/seta_coletor.webp', 
      'color': 0xFFA55BF7, 
      'description': 'Retail application for syncing inventory data with ERPs',
      'achievement': 'Reduced delays when scanning barcodes by using raw inputs from scanners',
      'users': '5 thousand retail stores all over Brazil',
      'platform': 'Android',
    },
    {
      'name': 'Seta Pré-Venda',
      'logo': '', 
      'color': 0xFFA55BF7, 
      'description': 'Retail application for making sales on the go',
      'achievement': 'Implemented Linx custom payment library with Stone Co. Smart PoS, reducing time to sale to 60 seconds',
      'users': '5 thousand retail stores all over Brazil',
      'platform': 'Android',
    },
  ];

  static const List<Map<String, dynamic>> skills = [
    {'name': 'Flutter/Dart', 'level': 0.98, 'category': 'Mobile'},
    {'name': 'Python/Django', 'level': 0.90, 'category': 'Backend'},
    {'name': 'SQL', 'level': 0.90, 'category': 'Backend'},
    {'name': 'NoSQL', 'level': 0.80, 'category': 'Backend'},
    {'name': 'Kotlin', 'level': 0.85, 'category': 'Mobile'},
    {'name': 'C/C++', 'level': 0.80, 'category': 'Embedded'},
    {'name': 'Clean Arch.', 'level': 0.95, 'category': 'Architecture'},
    {'name': 'SOLID', 'level': 0.95, 'category': 'Architecture'},
    {'name': 'Bloc/Cubit', 'level': 0.95, 'category': 'State Mgmt'},
    {'name': 'Riverpod', 'level': 0.85, 'category': 'State Mgmt'},
    {'name': 'CI/CD (Fastlane)', 'level': 0.85, 'category': 'DevOps'},
    {'name': 'Docker', 'level': 0.75, 'category': 'DevOps'},
    {'name': 'Git/GitLab', 'level': 0.90, 'category': 'Tools'},
    {'name': 'REST APIs', 'level': 0.92, 'category': 'Backend'},
    {'name': 'Unit Testing', 'level': 0.95, 'category': 'Quality'},
    {'name': 'Widget Testing', 'level': 0.90, 'category': 'Quality'},
    {'name': 'Integration Testing', 'level': 0.85, 'category': 'Quality'},
  ];

  static const List<Map<String, dynamic>> workHistory = [
    {
      'company': 'Ília (BMW Group)',
      'role': 'Mobile Software Engineer',
      'period': 'Sep 2024 - Present',
      'location': 'São Carlos, SP / Remote',
      'description': 'Driving innovation for the MyBMW and MINI apps in a global Agile environment.',
      'highlights': [
        'Develop complex mobile features using Flutter & Dart with robust Bloc/Cubit state management.',
        'Collaborate within a global cross-functional team to deliver premium automotive experiences.',
        'Ensure code quality and reliability by writing comprehensive unit and widget tests using bloc_test and mocktail',
      ],
    },
    {
      'company': 'Kindra',
      'role': 'Software Engineer',
      'period': 'Mar 2023 - Sep 2024',
      'location': 'Toledo, PR / Remote',
      'description': 'Led the full-stack architecture for a pioneering Agribusiness IoT startup.',
      'highlights': [
        'Architected cross-platform Flutter solutions and scalable Python/Django backend services.',
        'Engineered automated CI/CD pipelines using GitLab CI and Fastlane, reducing deployment time.',
        'Managed end-to-end product lifecycle for Google Play Store releases and updates.',
      ],
    },
    {
      'company': 'Linx',
      'role': 'R&D Developer',
      'period': 'Nov 2021 - Feb 2023',
      'location': 'Cascavel, PR',
      'description': 'Specialized in Smart POS hardware integration and payment ecosystems.',
      'highlights': [
        'Spearheaded the integration of Linx\'s custom payment system into Stone Smart POS devices.',
        'Integrated proprietary Android applications with Business Intelligence (BI) tools for real-time analytics.',
        'Maintained and secured legacy mobile codebases, ensuring operational stability.',
      ],
    },
    {
      'company': 'Kindra',
      'role': 'Software Engineer Intern',
      'period': 'Jan 2021 - Nov 2021',
      'location': 'Toledo, PR',
      'description': 'Focused on Embedded Systems, HMI, and real-time sensor communication.',
      'highlights': [
        'Engineered mobile HMI for IoT Smart Counting solutions using Flutter and REST APIs.',
        'Developed high-efficiency sensor backends in Python, later porting to C++ for performance optimization.',
      ],
    },
  ];
}