// lib/screens/project_requests.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

/// If you already have a central ApiClient (with interceptors), use that here.
/// For a quick start, this local Dio will also work. Set your base URL.
final Dio _dio = Dio(BaseOptions(
  baseUrl: 'http://inventerdesignstudio.com:5000',
  headers: const {
    'Content-Type': 'application/json',
    // CRITICAL: Security token header required by your backend
    'X-API-Security-Token': 'inventor-design-studio-api-2024-secure',
  },
));

class ProjectRequestsScreen extends StatefulWidget {
  const ProjectRequestsScreen({super.key});

  @override
  State<ProjectRequestsScreen> createState() => _ProjectRequestsScreenState();
}

class _ProjectRequestsScreenState extends State<ProjectRequestsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const dark = Color(0xFF111820);
    const panel = Color(0xFF1C242E);

    return Scaffold(
      backgroundColor: dark,
      body: SafeArea(
        child: Column(
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Row(
                children: const [
                  Text('Project Requests',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ),

            // Tabs bar (Overview | New Request)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: panel,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: _tab,
                  indicator: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'New Request'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Tab views
            Expanded(
              child: TabBarView(
                controller: _tab,
                physics: const BouncingScrollPhysics(),
                children: [
                  _OverviewTab(onCreateTap: () => _tab.animateTo(1)),
                  _NewRequestTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ============================ OVERVIEW TAB ============================ */

class _OverviewTab extends StatelessWidget {
  final VoidCallback onCreateTap;
  const _OverviewTab({required this.onCreateTap});

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD6FF23);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.description_outlined,
                size: 72, color: Color(0xFF4A5568)),
            const SizedBox(height: 16),
            const Text(
              'No project requests',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create your first project request to get started',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 22),
            ElevatedButton.icon(
              onPressed: onCreateTap,
              icon: const Icon(Icons.add),
              label: const Text('Create New Request'),
              style: ElevatedButton.styleFrom(
                backgroundColor: neon,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ============================ NEW REQUEST TAB ============================ */

class _NewRequestTab extends StatefulWidget {
  @override
  State<_NewRequestTab> createState() => _NewRequestTabState();
}

class _NewRequestTabState extends State<_NewRequestTab> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _budget = TextEditingController();
  final _timeline = TextEditingController();
  final _desc = TextEditingController();

  bool _submitting = false;
  bool _savingDraft = false;
  List<PlatformFile> _selectedFiles = [];
  final List<String> _uploadedFileUrls = [];

  @override
  void dispose() {
    _name.dispose();
    _budget.dispose();
    _timeline.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'txt'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles = result.files;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error selecting files')),
      );
    }
  }

  Future<List<String>> _uploadFiles() async {
    if (_selectedFiles.isEmpty) return [];

    List<String> uploadedUrls = [];

    for (final file in _selectedFiles) {
      try {
        // Create multipart file
        final multipartFile = await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
        );

        final formData = FormData.fromMap({
          'file': multipartFile,
          'type': 'project_attachment',
        });

        final response = await _dio.post(
          '/api/mobile/upload',
          data: formData,
        );

        if (response.data != null && response.data['url'] != null) {
          uploadedUrls.add(response.data['url']);
        }
      } catch (e) {
        debugPrint('Error uploading file ${file.name}: $e');
        // Continue with other files even if one fails
      }
    }

    return uploadedUrls;
  }

  Future<void> _saveDraft() async {
    if (!_form.currentState!.validate()) {
      // Optional: allow saving even if invalid
    }
    setState(() => _savingDraft = true);
    await Future.delayed(const Duration(milliseconds: 400)); // simulate
    setState(() => _savingDraft = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Draft saved locally')),
    );
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      // Upload files first if any selected
      List<String> fileUrls = [];
      if (_selectedFiles.isNotEmpty) {
        fileUrls = await _uploadFiles();
      }

      // If you already attach Authorization bearer in an interceptor, it will auto-include.
      // Otherwise, pass it here:
      // final jwt = await SecureStorage.read('access_token');
      // final headers = {'Authorization': 'Bearer $jwt'};

      await _dio.post(
        '/api/mobile/projects', // POST - Create New Project
        data: {
          'title': _name.text.trim(),
          'description': _desc.text.trim(),
          'budgetRange': _budget.text.trim(),
          'timeline': _timeline.text.trim(),
          'files': fileUrls, // Attach uploaded file URLs
          'feedback': 'Initial request from mobile',
        },
        // options: Options(headers: headers),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request submitted successfully')),
      );

      // Clear form after success
      _form.currentState!.reset();
      _name.clear();
      _budget.clear();
      _timeline.clear();
      _desc.clear();
      setState(() {
        _selectedFiles.clear();
        _uploadedFileUrls.clear();
      });
    } on DioException catch (e) {
      final msg = e.response?.data is Map && e.response?.data['message'] != null
          ? e.response!.data['message'].toString()
          : 'Submit failed';
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg)));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF1C242E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      );

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD6FF23);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Form(
        key: _form,
        child: ListView(
          children: [
            // Row: Project Name | Budget Range
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _name,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Enter project name' : null,
                    style: const TextStyle(color: Colors.white),
                    decoration: _dec('Enter project name'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _budget,
                    style: const TextStyle(color: Colors.white),
                    decoration: _dec('e.g., \$1000 - \$5000'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Timeline
            TextFormField(
              controller: _timeline,
              style: const TextStyle(color: Colors.white),
              decoration: _dec('e.g., 2–4 weeks'),
            ),
            const SizedBox(height: 12),

            // Description
            TextFormField(
              controller: _desc,
              maxLines: 8,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Describe your project requirements'
                  : null,
              style: const TextStyle(color: Colors.white),
              decoration: _dec('Describe your project requirements...'),
            ),
            const SizedBox(height: 16),

            // Upload files
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickFiles,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload Files'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C242E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                if (_selectedFiles.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${_selectedFiles.length} file${_selectedFiles.length > 1 ? 's' : ''} selected',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _selectedFiles.map((file) => Chip(
                      label: Text(
                        file.name,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      backgroundColor: const Color(0xFF2A2F38),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () {
                        setState(() {
                          _selectedFiles.remove(file);
                        });
                      },
                    )).toList(),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 28),

            // Bottom actions: Save Draft | Submit
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _savingDraft ? null : _saveDraft,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: _savingDraft
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Save Draft'),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _submitting ? null : _submit,
                    icon: const Icon(Icons.send),
                    label: _submitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.black),
                          )
                        : const Text('Submit Request'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: neon,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}