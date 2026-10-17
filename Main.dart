import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Müzik Uygulaması',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.white,
      ),
      home: const SongDetailScreen(),
    );
  }
}

class SongModel {
  final String title;
  final String artist;
  final String duration;
  final String lyrics;
  final String videoUrl;
  final int playCount;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.lyrics,
    required this.videoUrl,
    required this.playCount,
  });
}

class SongDetailScreen extends StatefulWidget {
  const SongDetailScreen({super.key});

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  // Şarkı Listesi
  final List<SongModel> songs = [
    SongModel(
      title: "Çeşme Başı Güzeli",
      artist: "Ercan Yüksel",
      duration: "3:45",
      lyrics: "Çeşme başı güzelidir yolu gözlenen,\nKalpte sızıdır adı gizlenen...",
      videoUrl: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
      playCount: 16,
    ),
    SongModel(
      title: "Bunun Adı Aşk Olmaz",
      artist: "Ercan Yüksel",
      duration: "4:10",
      lyrics: "Ayrılığın rengi solmaz,\nBunun adı aşk olmaz...",
      videoUrl: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
      playCount: 12,
    ),
    SongModel(
      title: "Bulutlar ve Sandallar",
      artist: "Ercan Yüksel",
      duration: "3:20",
      lyrics: "Denizde dalgalar vurur,\nSandallar sessiz durur...",
      videoUrl: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
      playCount: 14,
    ),
  ];

  late SongModel selectedSong;

  @override
  void initState() {
    super.initState();
    selectedSong = songs[0]; // Varsayılan ilk şarkı seçili
  }

  // MP4 Video Gösterim Ekranı
  void _playVideo(SongModel song) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(song.title, style: const TextStyle(color: Colors.white)),
        content: SizedBox(
          height: 200,
          child: Center(
            child: Text(
              "MP4 Video Oynatılıyor...\n(${song.videoUrl})",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Kapat", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Üç Noktaya Basıldığında Açılan Menü (Yorum Yap ve İstatistikler)
  void _showOptionsMenu(SongModel song) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.comment, color: Colors.white),
              title: const Text('Yorum Yap', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _showCommentDialog(song);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart, color: Colors.white),
              title: const Text('Şarkıya Ait İstatistik Bilgileri', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _showStatsDialog(song);
              },
            ),
          ],
        );
      },
    );
  }

  void _showCommentDialog(SongModel song) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${song.title} için Yorum Yap'),
        content: const TextField(
          decoration: InputDecoration(hintText: "Yorumunuzu buraya yazın..."),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Gönder")),
        ],
      ),
    );
  }

  void _showStatsDialog(SongModel song) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${song.title} İstatistikleri'),
        content: Text('Dinlenme Sayısı: ${song.playCount}\nToplam Dinlenme Süresi: 48 dk'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tamam")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Yönetim Paneli Butonu
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
            tooltip: 'Yönetim Paneli',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Bölüm (Seçilen Şarkı Adı ve Şarkı Sözleri)
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 'ManiDar' yerine dinamik seçilen şarkının adı
                  Text(
                    selectedSong.title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  // Şarkı Sözleri Alanı
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedSong.lyrics,
                      style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${selectedSong.artist} • ${songs.length} songs",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            // Şarkı Listesi (Beğeni butonu ve gereksiz simgeler kaldırıldı)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return ListTile(
                  onTap: () {
                    setState(() {
                      selectedSong = song;
                    });
                    _playVideo(song);
                  },
                  leading: Text(
                    "${index + 1}",
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  title: Text(
                    song.title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "${song.playCount} dinlenme • ${song.artist}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                    onPressed: () => _showOptionsMenu(song),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Yönetim Paneli Ekranı
class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yönetim Paneli'),
        backgroundColor: Colors.black54,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.library_music, color: Colors.white),
              title: const Text('Şarkı Ekle / Düzenle', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.lyrics, color: Colors.white),
              title: const Text('Şarkı Sözlerini Güncelle', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.analytics, color: Colors.white),
              title: const Text('İstatistik Raporları', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
