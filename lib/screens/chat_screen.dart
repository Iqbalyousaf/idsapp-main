import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String memberName;
  final String memberRole;
  final String memberAvatar;

  const ChatScreen({
    super.key,
    required this.memberName,
    required this.memberRole,
    required this.memberAvatar,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hey! How\'s the project coming along?',
      'isMe': false,
      'time': '10:30 AM',
      'avatar': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'text': 'Going well! Just finished the UI mockups. What do you think?',
      'isMe': true,
      'time': '10:32 AM',
    },
    {
      'text': 'Looks great! The color scheme really works. Ready to start development?',
      'isMe': false,
      'time': '10:35 AM',
      'avatar': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'text': 'Yes, I\'ll start tomorrow. Should have the basic structure done by end of week.',
      'isMe': true,
      'time': '10:37 AM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text.trim(),
        'isMe': true,
        'time': TimeOfDay.now().format(context),
      });
    });

    _messageController.clear();
  }

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
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.memberAvatar),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.memberName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.memberRole,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white70),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Voice call feature coming soon'),
                  backgroundColor: Color(0xFFD6FF23),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white70),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Video call feature coming soon'),
                  backgroundColor: Color(0xFFD6FF23),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white70),
            color: const Color(0xFF1A2029),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('View profile feature coming soon'),
                      backgroundColor: Color(0xFFD6FF23),
                    ),
                  );
                  break;
                case 'mute':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Chat muted'),
                      backgroundColor: Color(0xFFD6FF23),
                    ),
                  );
                  break;
                case 'block':
                  _showBlockConfirmation();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('View Profile', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: 'mute',
                child: Text('Mute Notifications', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: 'block',
                child: Text('Block User', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                  avatar: message['avatar'],
                );
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF1A2029),
              border: Border(
                top: BorderSide(color: Color(0xFF2A2F38)),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.white70),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('File sharing feature coming soon'),
                        backgroundColor: Color(0xFFD6FF23),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF0E131A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFD6FF23)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBlockConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2029),
        title: const Text(
          'Block User',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to block ${widget.memberName}? You won\'t be able to send or receive messages from this user.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to project details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.memberName} has been blocked'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Block',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  final String? avatar;

  const _MessageBubble({
    required this.text,
    required this.isMe,
    required this.time,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && avatar != null) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(avatar!),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFFD6FF23) : const Color(0xFF1A2029),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(16),
                ),
                border: Border.all(
                  color: isMe ? Colors.transparent : const Color(0xFF2A2F38),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.black : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      color: isMe ? Colors.black54 : Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}