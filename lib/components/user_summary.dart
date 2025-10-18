import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';
import 'package:inventor_desgin_studio/providers/user_provider.dart';

class UserSummary extends StatelessWidget {
  const UserSummary({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final name = userProvider.fullName;
        final role = userProvider.role.toUpperCase();
        final email = userProvider.email ?? '';
        final avatarText = userProvider.initials;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kStroke),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: kNeon.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: userProvider.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: kNeon),
                        )
                      : Text(
                          avatarText.isEmpty ? 'U' : avatarText,
                          style: const TextStyle(
                            color: kNeon,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.isLoading ? 'Loading...' : (name.isEmpty ? 'User' : name),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    if (!userProvider.isLoading && email.isNotEmpty)
                      Text(email, style: const TextStyle(color: Colors.white70)),
                    Text(role, style: const TextStyle(color: Colors.white38)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}