import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';

class BrowseFilesScreen extends StatefulWidget {
  const BrowseFilesScreen({super.key});

  @override
  State<BrowseFilesScreen> createState() => _BrowseFilesScreenState();
}

class _BrowseFilesScreenState extends State<BrowseFilesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Images', 'Documents', 'Videos', 'Audio'];

  final List<Map<String, dynamic>> _files = [
    {
      'name': 'project_mockup.png',
      'type': 'Image',
      'size': '2.4 MB',
      'date': '2024-01-15',
      'icon': Icons.image,
      'color': Colors.blue,
    },
    {
      'name': 'design_spec.pdf',
      'type': 'Document',
      'size': '1.8 MB',
      'date': '2024-01-14',
      'icon': Icons.picture_as_pdf,
      'color': Colors.red,
    },
    {
      'name': 'presentation.mp4',
      'type': 'Video',
      'size': '45.2 MB',
      'date': '2024-01-13',
      'icon': Icons.video_file,
      'color': Colors.purple,
    },
    {
      'name': 'background_music.mp3',
      'type': 'Audio',
      'size': '8.7 MB',
      'date': '2024-01-12',
      'icon': Icons.audio_file,
      'color': Colors.green,
    },
    {
      'name': 'wireframe.fig',
      'type': 'Document',
      'size': '3.1 MB',
      'date': '2024-01-11',
      'icon': Icons.design_services,
      'color': Colors.orange,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E131A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Browse Files',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search files...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF1A2029),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Filters
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == _selectedFilter;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedFilter = filter);
                    },
                    backgroundColor: const Color(0xFF1A2029),
                    selectedColor: kNeon.withValues(alpha: 0.2),
                    checkmarkColor: kNeon,
                    labelStyle: TextStyle(
                      color: isSelected ? kNeon : Colors.white70,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // Files List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _files.length,
              itemBuilder: (context, index) {
                final file = _files[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2029),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2A2F38)),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: file['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(file['icon'], color: file['color']),
                    ),
                    title: Text(
                      file['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${file['type']} • ${file['size']} • ${file['date']}',
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white54),
                      onPressed: () {
                        _showFileOptions(context, file);
                      },
                    ),
                    onTap: () {
                      _openFile(file);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showUploadDialog();
        },
        backgroundColor: kNeon,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showFileOptions(BuildContext context, Map<String, dynamic> file) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A2029),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.visibility, color: Colors.white70),
              title: const Text('Preview', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _previewFile(file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white70),
              title: const Text('Share', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _shareFile(file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.download, color: Colors.white70),
              title: const Text('Download', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _downloadFile(file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteFile(file);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openFile(Map<String, dynamic> file) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${file['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _previewFile(Map<String, dynamic> file) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Previewing ${file['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _shareFile(Map<String, dynamic> file) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${file['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _downloadFile(Map<String, dynamic> file) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading ${file['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _deleteFile(Map<String, dynamic> file) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleting ${file['name']}'),
        backgroundColor: kNeon,
      ),
    );
  }

  void _showUploadDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A2029),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Upload Files',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, color: Colors.blue),
              ),
              title: const Text('Upload Images', style: TextStyle(color: Colors.white)),
              subtitle: const Text('PNG, JPG, GIF', style: TextStyle(color: Colors.white54)),
              onTap: () {
                Navigator.pop(context);
                _uploadFile('image');
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.picture_as_pdf, color: Colors.red),
              ),
              title: const Text('Upload Documents', style: TextStyle(color: Colors.white)),
              subtitle: const Text('PDF, DOC, TXT', style: TextStyle(color: Colors.white54)),
              onTap: () {
                Navigator.pop(context);
                _uploadFile('document');
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.video_file, color: Colors.purple),
              ),
              title: const Text('Upload Videos', style: TextStyle(color: Colors.white)),
              subtitle: const Text('MP4, AVI, MOV', style: TextStyle(color: Colors.white54)),
              onTap: () {
                Navigator.pop(context);
                _uploadFile('video');
              },
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.audio_file, color: Colors.green),
              ),
              title: const Text('Upload Audio', style: TextStyle(color: Colors.white)),
              subtitle: const Text('MP3, WAV, FLAC', style: TextStyle(color: Colors.white54)),
              onTap: () {
                Navigator.pop(context);
                _uploadFile('audio');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _uploadFile(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Upload $type functionality - File picker would open here'),
        backgroundColor: kNeon,
      ),
    );
  }
}